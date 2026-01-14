import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Password input field widget with visibility toggle
/// Includes eye icon for showing/hiding password
class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.errorText,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final VoidCallback? onSubmitted;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mot de passe',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: !_isPasswordVisible,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onChanged: widget.onChanged,
          onSubmitted: (_) => widget.onSubmitted?.call(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: '••••••••',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                size: 5.w,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            suffixIcon: IconButton(
              icon: CustomIconWidget(
                iconName: _isPasswordVisible ? 'visibility' : 'visibility_off',
                size: 5.w,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            errorText: widget.errorText,
            errorMaxLines: 2,
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.5.h,
            ),
          ),
        ),
      ],
    );
  }
}
