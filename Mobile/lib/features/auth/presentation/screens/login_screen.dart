import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      padding: const EdgeInsets.fromLTRB(24, 72, 24, 32),
      decoration: const BoxDecoration(
        gradient: AppTheme.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // استبدال السطر 59 بهذا الـ Container:
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

          const SizedBox(height: 16),
          Text(
            context.l10n.welcomeBack,
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.signInToContinue,
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
            const SizedBox(height: 8),
            Text(
              context.l10n.loginToYourAccount,
              style: AppTextStyles.heading3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),

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
              hint: context.l10n.passwordHint,
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
                if (v.length < 8) {
                  return context.l10n.passwordTooShort(8);
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.pushNamed(RouteNames.forgotPassword),
                child: Text(context.l10n.forgotPasswordQ),
              ),
            ),
            const SizedBox(height: 16),

            // Login Button
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (prev, curr) =>
                  curr is AuthLoading ||
                  curr is AuthError ||
                  curr is AuthSuccess,
              builder: (context, state) {
                return AppButton(
                  text: context.l10n.login,
                  isLoading: state is AuthLoading,
                  onPressed: _onLogin,
                );
              },
            ),
            const SizedBox(height: 24),

            // Divider
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.l10n.orContinueWith,
                    style: AppTextStyles.bodySm.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),

            // Social Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _onGoogleSignIn,
                    icon: const Icon(Icons.g_mobiledata, size: 24),
                    label: Text(context.l10n.google),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.dontHaveAccount,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pushNamed(RouteNames.signUp),
                  child: Text(
                    context.l10n.signUp,
                    style: AppTextStyles.label.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
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

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  Future<void> _onGoogleSignIn() async {
    try {
      final googleSignIn = GoogleSignIn(
        serverClientId: '80992510984-48oj53m9t3ebdknqvtb810p899v4jc88.apps.googleusercontent.com',
      );
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final auth = await googleUser.authentication;
      final idToken = auth.idToken;
      if (idToken == null) return;
      if (!mounted) {
        return;
      }
      context.read<AuthCubit>().googleLogin(idToken: idToken);
    } catch (_) {
      // Google sign-in cancelled or failed.
    }
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    switch (state) {
      case AuthSuccess(:final result):
        if (result.user.isDoctor) {
          context.read<AuthCubit>().getDoctorStatus();
        } else {
          context.goNamed(RouteNames.patientHome);
        }
      case AuthDoctorStatusLoaded(:final result):
        if (result.isApproved) {
          context.goNamed(RouteNames.doctorHome);
        } else if (result.isRejected) {
          context.goNamed(
            RouteNames.doctorRejected,
            extra: result.rejectionReason,
          );
        } else {
          context.goNamed(RouteNames.doctorPending);
        }
      case AuthGoogleResult(:final result):
        if (result.authResult != null) {
          if (result.authResult!.user.isDoctor) {
            context.read<AuthCubit>().getDoctorStatus();
          } else {
            context.goNamed(RouteNames.patientHome);
          }
        }
      case AuthError(:final message):
        final lowerMessage = message.toLowerCase();
        if (lowerMessage.contains('rejected')) {
          String? reason;
          if (message.contains('Reason:')) {
            reason = message
                .split(RegExp(r'Reason:\s*', caseSensitive: false))
                .last;
          }
          context.goNamed(RouteNames.doctorRejected, extra: reason);
        } else if (lowerMessage.contains('under review') ||
            lowerMessage.contains('pending')) {
          context.goNamed(RouteNames.doctorPending);
        } else {
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
        }

      default:
        break;
    }
  }
}
