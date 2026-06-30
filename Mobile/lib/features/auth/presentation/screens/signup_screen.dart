import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/password_strength_indicator.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../cubits/specialty_cubit.dart';
import '../cubits/specialty_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String _selectedRole = 'Patient';
  String? _selectedSpecialtyId;
  bool _agreedToTerms = false;
  String _passwordValue = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(
      () => setState(() => _passwordValue = _passwordController.text),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleAuthState,
        child: SingleChildScrollView(
          child: Column(children: [_buildHeader(), _buildForm()]),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
      decoration: const BoxDecoration(
        gradient: AppTheme.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset('assets/icons/app_logo.png', height: 48),
          ),

          const SizedBox(height: 12),
          Text(
            context.l10n.createAccount,
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.joinToday,
            style: AppTextStyles.bodyMd.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Selector
            Text(context.l10n.iAmA, style: AppTextStyles.label),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildRoleChip('Patient', context.l10n.patient, Icons.person)),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoleChip('Doctor', context.l10n.doctor, Icons.medical_services),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name fields
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: context.l10n.firstName,
                    hint: context.l10n.firstNameHint,
                    controller: _firstNameController,
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    validator: (v) =>
                        v == null || v.isEmpty ? context.l10n.requiredField : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    label: context.l10n.lastName,
                    hint: context.l10n.lastNameHint,
                    controller: _lastNameController,
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    validator: (v) =>
                        v == null || v.isEmpty ? context.l10n.requiredField : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Email
            AppTextField(
              label: context.l10n.emailAddress,
              hint: context.l10n.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
              validator: (v) {
                if (v == null || v.isEmpty) return context.l10n.emailRequired;
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                  return context.l10n.emailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password
            AppTextField(
              label: context.l10n.password,
              hint: context.l10n.min8Chars,
              controller: _passwordController,
              obscureText: _obscurePassword,
              prefixIcon: const Icon(Icons.lock_outlined, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return context.l10n.passwordRequired;
                if (v.length < 8) return context.l10n.min8Chars;
                return null;
              },
            ),
            if (_passwordValue.isNotEmpty) ...[
              const SizedBox(height: 10),
              PasswordStrengthIndicator(password: _passwordValue),
            ],
            const SizedBox(height: 16),

            // Confirm Password
            AppTextField(
              label: context.l10n.confirmPassword,
              hint: context.l10n.confirmPasswordHint,
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              prefixIcon: const Icon(Icons.lock_outlined, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              validator: (v) {
                if (v != _passwordController.text) {
                  return context.l10n.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Specialty Dropdown (Doctor only)
            if (_selectedRole == 'Doctor') ...[
              Text(context.l10n.specialty, style: AppTextStyles.label),
              const SizedBox(height: 8),
              BlocBuilder<SpecialtyCubit, SpecialtyState>(
                builder: (context, specialtyState) {
                  final isLoading = specialtyState is SpecialtyLoading;
                  final items = specialtyState is SpecialtyLoaded
                      ? specialtyState.specialties
                      : <dynamic>[];

                  final dropdownColor = Theme.of(
                    context,
                  ).inputDecorationTheme.fillColor;

                  return FormField<String>(
                    initialValue: _selectedSpecialtyId,
                    validator: (v) => v == null ? context.l10n.requiredField : null,
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          hintText: isLoading
                              ? context.l10n.loading
                              : context.l10n.selectSpecialty,
                          prefixIcon: const Icon(
                            Icons.local_hospital_outlined,
                            size: 20,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 9,
                          ),
                          errorText: state.errorText,
                        ),
                        isEmpty: _selectedSpecialtyId == null,
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: DropdownButton<String>(
                              value: _selectedSpecialtyId,
                              dropdownColor: dropdownColor,
                              borderRadius: BorderRadius.circular(12),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, size: 24),
                              items: items
                                  .map(
                                    (s) => DropdownMenuItem<String>(
                                      value: s.id,
                                      child: Text(s.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: isLoading
                                  ? null
                                  : (value) {
                                      setState(
                                        () => _selectedSpecialtyId = value,
                                      );
                                      state.didChange(value);
                                    },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),

              // Doctor info banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  border: Border.all(color: Colors.orange.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange.shade700,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        context.l10n.doctorNextStepInfo,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: Colors.orange.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Terms & Conditions checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _agreedToTerms,
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (v) =>
                        setState(() => _agreedToTerms = v ?? false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(text: context.l10n.iAgreeToThe),
                        TextSpan(
                          text: context.l10n.termsConditions,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: context.l10n.and),
                        TextSpan(
                          text: context.l10n.privacyPolicy,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (_, curr) =>
                  curr is AuthLoading ||
                  curr is AuthError ||
                  curr is AuthRegistered,
              builder: (context, state) {
                return AppButton(
                  text: context.l10n.signUp,
                  isLoading: state is AuthLoading,
                  onPressed: _onSignUp,
                );
              },
            ),
            const SizedBox(height: 20),

            // Divider
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    context.l10n.or,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),

            // Google Sign Up
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata, size: 22),
                label: Text(context.l10n.continueWithGoogle),
                onPressed: _onGoogleSignUp,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: AppColors.divider),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.alreadyHaveAccount,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Text(
                    context.l10n.login,
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleChip(String roleId, String label, IconData icon) {
    final isSelected = _selectedRole == roleId;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedRole = roleId;
        _selectedSpecialtyId = null;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onGoogleSignUp() async {
    if (_selectedRole == 'Doctor' && (_selectedSpecialtyId == null || _selectedSpecialtyId!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pleaseSelectSpecialty),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }
    try {
      final googleSignIn = GoogleSignIn(
        serverClientId: '80992510984-48oj53m9t3ebdknqvtb810p899v4jc88.apps.googleusercontent.com',
      );
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null || !mounted) return;
      final auth = await googleUser.authentication;
      final idToken = auth.idToken;
      if (idToken == null || !mounted) return;
      context.read<AuthCubit>().googleLogin(
        idToken: idToken,
        role: _selectedRole,
        specialtyId: _selectedRole == 'Doctor' ? _selectedSpecialtyId : null,
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.googleSignUpFailed)),
      );
    }
  }

  void _onSignUp() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pleaseAgreeToTerms),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedRole == 'Doctor' && _selectedSpecialtyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pleaseSelectSpecialty)),
        );
        return;
      }

      context.read<AuthCubit>().register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        role: _selectedRole,
        specialtyId: _selectedRole == 'Doctor' ? _selectedSpecialtyId : null,
      );
    }
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    switch (state) {
      case AuthRegistered(:final result):
        if (result.requiresDocumentUpload) {
          context.goNamed(
            RouteNames.doctorDocuments,
            extra: result.pendingToken ?? '',
          );
        } else if (result.authResult != null) {
          context.goNamed(RouteNames.patientHome);
        }
      case AuthGoogleResult(:final result):
        if (result.authResult == null && result.pendingToken != null) {
          // Doctor signed up via Google — needs document upload
          context.goNamed(
            RouteNames.doctorDocuments,
            extra: result.pendingToken ?? '',
          );
        } else if (result.authResult != null) {
          context.goNamed(RouteNames.patientHome);
        }
      case AuthError(:final message):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
      default:
        break;
    }
  }
}
