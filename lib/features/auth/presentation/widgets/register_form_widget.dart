import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Registration form widget with all input fields and validation
class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onChanged,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onChanged;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _passwordStrength = '';
  Color _strengthColor = Colors.grey;

  void _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = '';
        _strengthColor = Colors.grey;
      });
      return;
    }

    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    setState(() {
      if (strength <= 1) {
        _passwordStrength = 'Faible';
        _strengthColor = Colors.red;
      } else if (strength == 2) {
        _passwordStrength = 'Moyen';
        _strengthColor = Colors.orange;
      } else if (strength == 3) {
        _passwordStrength = 'Bon';
        _strengthColor = Colors.blue;
      } else {
        _passwordStrength = 'Fort';
        _strengthColor = Colors.green;
      }
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom complet';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre adresse e-mail';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une majuscule';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != widget.passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full name field
        TextFormField(
          controller: widget.nameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: _validateName,
          onChanged: (_) => widget.onChanged(),
          decoration: InputDecoration(
            labelText: 'Nom complet',
            hintText: 'Entrez votre nom complet',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'person_outline',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),

        // Email field
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: _validateEmail,
          onChanged: (_) => widget.onChanged(),
          decoration: InputDecoration(
            labelText: 'Adresse e-mail',
            hintText: 'exemple@email.com',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'email_outlined',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),

        // Password field
        TextFormField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.next,
          validator: _validatePassword,
          onChanged: (value) {
            _checkPasswordStrength(value);
            widget.onChanged();
          },
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            hintText: 'Entrez votre mot de passe',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock_outline',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: IconButton(
              icon: CustomIconWidget(
                iconName: _obscurePassword
                    ? 'visibility_outlined'
                    : 'visibility_off_outlined',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
        ),
        if (_passwordStrength.isNotEmpty) ...[
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                'Force du mot de passe: ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                _passwordStrength,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _strengthColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: 2.h),

        // Confirm password field
        TextFormField(
          controller: widget.confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          textInputAction: TextInputAction.done,
          validator: _validateConfirmPassword,
          onChanged: (_) => widget.onChanged(),
          decoration: InputDecoration(
            labelText: 'Confirmer le mot de passe',
            hintText: 'Confirmez votre mot de passe',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock_outline',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: IconButton(
              icon: CustomIconWidget(
                iconName: _obscureConfirmPassword
                    ? 'visibility_outlined'
                    : 'visibility_off_outlined',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              onPressed: () {
                setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
