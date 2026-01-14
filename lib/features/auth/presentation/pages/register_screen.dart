import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';
import './widgets/register_form_widget.dart';
import './widgets/terms_checkbox_widget.dart';

/// Register Screen for new user account creation
/// Implements Firebase authentication with comprehensive form validation
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _termsAccepted = false;
  bool _privacyAccepted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  bool get _canSubmit {
    return _isFormValid && _termsAccepted && _privacyAccepted && !_isLoading;
  }

  Future<void> _handleRegistration() async {
    if (!_canSubmit) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate Firebase registration
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Mock validation - check for duplicate email
    if (_emailController.text.toLowerCase() == 'test@example.com') {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Cette adresse e-mail est déjà utilisée';
      });
      return;
    }

    // Success - navigate to dashboard
    Navigator.pushReplacementNamed(context, '/user-dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/image-1767396189878.png',
              width: 8.w,
              height: 8.w,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.flight,
                  size: 6.w,
                  color: theme.colorScheme.primary,
                );
              },
            ),
            SizedBox(width: 2.w),
            Text(
              'Pegasus',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Créer un compte',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Rejoignez Pegasus pour gérer vos tâches efficacement',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),

                // Error message
                if (_errorMessage != null) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.w),
                      border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'error_outline',
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],

                // Registration form
                RegisterFormWidget(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  onChanged: () => setState(() {}),
                ),
                SizedBox(height: 3.h),

                // Terms and privacy checkboxes
                TermsCheckboxWidget(
                  termsAccepted: _termsAccepted,
                  privacyAccepted: _privacyAccepted,
                  onTermsChanged: (value) {
                    setState(() => _termsAccepted = value ?? false);
                  },
                  onPrivacyChanged: (value) {
                    setState(() => _privacyAccepted = value ?? false);
                  },
                ),
                SizedBox(height: 4.h),

                // Create account button
                SizedBox(
                  width: double.infinity,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _handleRegistration : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      disabledBackgroundColor: theme
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.12),
                      disabledForegroundColor: theme
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      elevation: _canSubmit ? 2 : 0,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            'Créer un compte',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: _canSubmit
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.38),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 3.h),

                // Login link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Vous avez déjà un compte? ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          '/login-screen',
                        ),
                        child: Text(
                          'Se connecter',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
