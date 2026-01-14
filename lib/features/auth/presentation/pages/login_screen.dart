import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/routes/app_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import './widgets/email_input_widget.dart';
import './widgets/forgot_password_widget.dart';
import './widgets/login_button_widget.dart';
import './widgets/logo_section_widget.dart';
import './widgets/password_input_widget.dart';
import './widgets/register_link_widget.dart';

/// Login Screen - Firebase authentication with role-based navigation
/// Provides secure login with email/password.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void handleLogin(BuildContext context) {
      FocusScope.of(context).unfocus();
      // The form validation logic can be kept if desired, or simplified.
      // For this refactoring, we'll dispatch the event and let the BLoC handle logic.
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              email: emailController.text.trim(),
              password: passwordController.text,
            ),
          );
    }

    void handleRegister(BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.registerScreen);
    }
    
    void handleForgotPassword(BuildContext context) {
      // Logic for forgot password can be handled here or by dispatching an event
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            HapticFeedback.lightImpact();
            Navigator.pushReplacementNamed(context, AppRoutes.userDashboard);
          } else if (state is AuthFailure) {
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoSectionWidget(),
                      SizedBox(height: 1.h),
                      Text(
                        'Bienvenue sur Pegasus.com',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      EmailInputWidget(
                        controller: emailController,
                        focusNode: FocusNode(),
                        errorText: null, // Error is now handled by the listener
                      ),
                      SizedBox(height: 2.h),
                      PasswordInputWidget(
                        controller: passwordController,
                        focusNode: FocusNode(),
                        errorText: null, // Error is now handled by the listener
                        onSubmitted: () => handleLogin(context),
                      ),
                      SizedBox(height: 1.h),
                      ForgotPasswordWidget(onTap: () => handleForgotPassword(context)),
                      SizedBox(height: 4.h),
                      LoginButtonWidget(
                        onPressed: () => handleLogin(context),
                        isLoading: isLoading,
                        isEnabled: !isLoading, // Button is enabled when not loading
                      ),
                      SizedBox(height: 3.h),
                      RegisterLinkWidget(onTap: () => handleRegister(context)),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
