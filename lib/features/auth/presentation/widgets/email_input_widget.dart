import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Email input field widget with validation and autocomplete
/// Includes envelope icon and email keyboard type
class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          onChanged: onChanged,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'exemple@email.com',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'email',
                size: 5.w,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            errorText: errorText,
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
