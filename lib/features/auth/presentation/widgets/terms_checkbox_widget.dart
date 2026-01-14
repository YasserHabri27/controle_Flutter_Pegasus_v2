import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Terms and privacy policy checkbox widget
class TermsCheckboxWidget extends StatelessWidget {
  const TermsCheckboxWidget({
    super.key,
    required this.termsAccepted,
    required this.privacyAccepted,
    required this.onTermsChanged,
    required this.onPrivacyChanged,
  });

  final bool termsAccepted;
  final bool privacyAccepted;
  final ValueChanged<bool?> onTermsChanged;
  final ValueChanged<bool?> onPrivacyChanged;

  void _showTermsDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Conditions d\'utilisation',
          style: theme.textTheme.titleLarge,
        ),
        content: SingleChildScrollView(
          child: Text(
            'En utilisant Pegasus Workflow Manager, vous acceptez de:\n\n'
            '1. Utiliser l\'application de manière responsable\n'
            '2. Ne pas partager vos identifiants de connexion\n'
            '3. Respecter les droits de propriété intellectuelle\n'
            '4. Ne pas utiliser l\'application à des fins illégales\n'
            '5. Maintenir la confidentialité de vos données\n\n'
            'Pegasus se réserve le droit de modifier ces conditions à tout moment.',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Politique de confidentialité',
          style: theme.textTheme.titleLarge,
        ),
        content: SingleChildScrollView(
          child: Text(
            'Pegasus Workflow Manager s\'engage à protéger votre vie privée:\n\n'
            '1. Collecte de données: Nous collectons uniquement les informations nécessaires au fonctionnement de l\'application\n'
            '2. Utilisation: Vos données sont utilisées pour améliorer votre expérience\n'
            '3. Partage: Nous ne partageons pas vos données avec des tiers sans votre consentement\n'
            '4. Sécurité: Vos données sont stockées de manière sécurisée\n'
            '5. Droits: Vous pouvez demander l\'accès, la modification ou la suppression de vos données\n\n'
            'Pour plus d\'informations, contactez-nous à privacy@pegasus.com',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Terms of service checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: termsAccepted,
                onChanged: onTermsChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  children: [
                    TextSpan(text: 'J\'accepte les '),
                    TextSpan(
                      text: 'Conditions d\'utilisation',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _showTermsDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),

        // Privacy policy checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: privacyAccepted,
                onChanged: onPrivacyChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  children: [
                    TextSpan(text: 'J\'accepte la '),
                    TextSpan(
                      text: 'Politique de confidentialité',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _showPrivacyDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
