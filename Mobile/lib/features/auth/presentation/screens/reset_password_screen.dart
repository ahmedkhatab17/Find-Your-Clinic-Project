import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/password_strength_indicator.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
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
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleState,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildForm(),
            ],
          ),
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
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const Icon(Icons.vpn_key, size: 56, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            'New Password',
            style: AppTextStyles.heading1.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a strong password for your account',
            style: AppTextStyles.bodyMd.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
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
          children: [
            const SizedBox(height: 24),
            AppTextField(
              label: 'New Password',
              hint: 'Min. 8 characters',
              controller: _passwordController,
              obscureText: _obscure1,
              prefixIcon: const Icon(Icons.lock_outlined, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure1 ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure1 = !_obscure1),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                if (v.length < 8) return 'Min. 8 characters';
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Shared strength indicator
            if (_passwordValue.isNotEmpty)
              PasswordStrengthIndicator(password: _passwordValue),

            const SizedBox(height: 16),
            AppTextField(
              label: 'Confirm Password',
              hint: 'Re-enter password',
              controller: _confirmController,
              obscureText: _obscure2,
              prefixIcon: const Icon(Icons.lock_outlined, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure2 ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure2 = !_obscure2),
              ),
              validator: (v) {
                if (v != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (_, curr) =>
                  curr is AuthLoading ||
                  curr is AuthPasswordResetSuccess ||
                  curr is AuthError,
              builder: (context, state) {
                return AppButton(
                  text: 'Reset Password',
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthCubit>().resetPassword(
                            token: widget.token,
                            newPassword: _passwordController.text,
                          );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleState(BuildContext context, AuthState state) {
    switch (state) {
      case AuthPasswordResetSuccess():
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: const Text('Password reset successfully! Please login.'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          );
        context.goNamed(RouteNames.login);
      case AuthError(:final message):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          );
      default:
        break;
    }
  }
}
