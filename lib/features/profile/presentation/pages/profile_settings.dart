import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/widgets/custom_app_bar.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';
import './widgets/notification_settings_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/theme_selector_widget.dart';

/// Profile Settings screen providing comprehensive user customization
/// Implements Contemporary Productive Minimalism with Material Design 3
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // User data
  String _userName = 'Marie Dubois';
  String _userRole = 'Utilisateur';
  String _userEmail = 'marie.dubois@example.fr';
  String _avatarUrl =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400';

  // Settings state
  String _currentTheme = 'system';
  bool _biometricAuth = false;
  String _language = 'Français';
  String _dateFormat = 'DD/MM/YYYY';
  bool _taskReminders = true;
  bool _workflowUpdates = true;
  bool _dailyDigest = false;
  int _dailyGoal = 5;
  String _reminderTime = '09:00';
  bool _weeklyReport = true;
  String _syncStatus = 'Synchronisé';
  bool _dataUsage = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Paramètres',
        variant: AppBarVariant.standard,
        actions: [CustomAppBarActions.moreAction(onPressed: _showMoreOptions)],
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: colorScheme.outline, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Profil'),
                Tab(text: 'Préférences'),
              ],
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildProfileTab(), _buildPreferencesTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile header
          ProfileHeaderWidget(
            userName: _userName,
            userRole: _userRole,
            avatarUrl: _avatarUrl,
            onEditPhoto: _showPhotoOptions,
          ),
          SizedBox(height: 2.h),
          // Account section
          SettingsSectionWidget(
            title: 'COMPTE',
            children: [
              SettingsItemWidget(
                icon: 'person',
                title: 'Modifier le profil',
                subtitle: _userEmail,
                onTap: _editProfile,
              ),
              SettingsItemWidget(
                icon: 'lock',
                title: 'Changer le mot de passe',
                onTap: _changePassword,
              ),
              SettingsItemWidget(
                icon: 'fingerprint',
                title: 'Authentification biométrique',
                trailing: Switch(
                  value: _biometricAuth,
                  onChanged: (value) {
                    setState(() => _biometricAuth = value);
                  },
                ),
                showDivider: false,
              ),
            ],
          ),
          // Data Management section
          SettingsSectionWidget(
            title: 'GESTION DES DONNÉES',
            children: [
              SettingsItemWidget(
                icon: 'download',
                title: 'Exporter les données',
                subtitle: 'Télécharger toutes vos données',
                onTap: _exportData,
              ),
              SettingsItemWidget(
                icon: 'sync',
                title: 'État de synchronisation',
                subtitle: _syncStatus,
                trailing: CustomIconWidget(
                  iconName: 'check_circle',
                  color: colorScheme.tertiary,
                  size: 5.w,
                ),
              ),
              SettingsItemWidget(
                icon: 'delete_sweep',
                title: 'Effacer le cache',
                subtitle: 'Libérer de l\'espace de stockage',
                onTap: _clearCache,
                showDivider: false,
              ),
            ],
          ),
          // Privacy section
          SettingsSectionWidget(
            title: 'CONFIDENTIALITÉ',
            children: [
              SettingsItemWidget(
                icon: 'security',
                title: 'Utilisation des données',
                trailing: Switch(
                  value: _dataUsage,
                  onChanged: (value) {
                    setState(() => _dataUsage = value);
                  },
                ),
              ),
              SettingsItemWidget(
                icon: 'delete_forever',
                title: 'Supprimer le compte',
                subtitle: 'Action irréversible',
                onTap: _deleteAccount,
                showDivider: false,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Logout button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: const Text('Se déconnecter'),
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.h),
          // Theme section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ThemeSelectorWidget(
              currentTheme: _currentTheme,
              onThemeChanged: (theme) {
                setState(() => _currentTheme = theme);
                _applyTheme(theme);
              },
            ),
          ),
          SizedBox(height: 2.h),
          // Preferences section
          SettingsSectionWidget(
            title: 'PRÉFÉRENCES',
            children: [
              SettingsItemWidget(
                icon: 'language',
                title: 'Langue',
                subtitle: _language,
                onTap: _selectLanguage,
              ),
              SettingsItemWidget(
                icon: 'calendar_today',
                title: 'Format de date',
                subtitle: _dateFormat,
                onTap: _selectDateFormat,
                showDivider: false,
              ),
            ],
          ),
          // Notifications section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'NOTIFICATIONS',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: NotificationSettingsWidget(
              taskReminders: _taskReminders,
              workflowUpdates: _workflowUpdates,
              dailyDigest: _dailyDigest,
              onTaskRemindersChanged: (value) {
                setState(() => _taskReminders = value);
              },
              onWorkflowUpdatesChanged: (value) {
                setState(() => _workflowUpdates = value);
              },
              onDailyDigestChanged: (value) {
                setState(() => _dailyDigest = value);
              },
            ),
          ),
          SizedBox(height: 2.h),
          // Productivity section
          SettingsSectionWidget(
            title: 'PRODUCTIVITÉ',
            children: [
              SettingsItemWidget(
                icon: 'flag',
                title: 'Objectif quotidien',
                subtitle: '$_dailyGoal tâches par jour',
                onTap: _setDailyGoal,
              ),
              SettingsItemWidget(
                icon: 'alarm',
                title: 'Heure de rappel',
                subtitle: _reminderTime,
                onTap: _setReminderTime,
              ),
              SettingsItemWidget(
                icon: 'assessment',
                title: 'Rapport hebdomadaire',
                trailing: Switch(
                  value: _weeklyReport,
                  onChanged: (value) {
                    setState(() => _weeklyReport = value);
                  },
                ),
                showDivider: false,
              ),
            ],
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  void _showPhotoOptions() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'camera_alt',
                  color: colorScheme.primary,
                  size: 6.w,
                ),
                title: const Text('Prendre une photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'photo_library',
                  color: colorScheme.primary,
                  size: 6.w,
                ),
                title: const Text('Choisir dans la galerie'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'delete',
                  color: colorScheme.error,
                  size: 6.w,
                ),
                title: Text(
                  'Supprimer la photo',
                  style: TextStyle(color: colorScheme.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _removePhoto();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _takePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité caméra à implémenter')),
    );
  }

  void _pickFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité galerie à implémenter')),
    );
  }

  void _removePhoto() {
    setState(() {
      _avatarUrl =
          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=400';
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Photo de profil supprimée')));
  }

  void _editProfile() {
    Navigator.pushNamed(context, '/edit-profile');
  }

  void _changePassword() {
    Navigator.pushNamed(context, '/change-password');
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exporter les données'),
        content: const Text(
          'Vos données seront exportées au format JSON et téléchargées sur votre appareil.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export des données en cours...')),
              );
            },
            child: const Text('Exporter'),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer le cache'),
        content: const Text(
          'Cette action supprimera toutes les données en cache. Continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache effacé avec succès')),
              );
            },
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text(
          'Cette action est irréversible. Toutes vos données seront définitivement supprimées. Êtes-vous sûr ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmDeleteAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation finale'),
        content: const Text(
          'Tapez "SUPPRIMER" pour confirmer la suppression de votre compte.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Compte supprimé')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _applyTheme(String theme) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Thème changé: $theme')));
  }

  void _selectLanguage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sélectionner la langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Français'),
              value: 'Français',
              groupValue: _language,
              onChanged: (value) {
                setState(() => _language = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _language,
              onChanged: (value) {
                setState(() => _language = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectDateFormat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Format de date'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('DD/MM/YYYY'),
              value: 'DD/MM/YYYY',
              groupValue: _dateFormat,
              onChanged: (value) {
                setState(() => _dateFormat = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('MM/DD/YYYY'),
              value: 'MM/DD/YYYY',
              groupValue: _dateFormat,
              onChanged: (value) {
                setState(() => _dateFormat = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('YYYY-MM-DD'),
              value: 'YYYY-MM-DD',
              groupValue: _dateFormat,
              onChanged: (value) {
                setState(() => _dateFormat = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setDailyGoal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Objectif quotidien'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nombre de tâches: $_dailyGoal'),
            Slider(
              value: _dailyGoal.toDouble(),
              min: 1,
              max: 20,
              divisions: 19,
              label: _dailyGoal.toString(),
              onChanged: (value) {
                setState(() => _dailyGoal = value.toInt());
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _setReminderTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _reminderTime =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'help',
                color: Theme.of(context).colorScheme.primary,
                size: 6.w,
              ),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Page d\'aide à implémenter')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'info',
                color: Theme.of(context).colorScheme.primary,
                size: 6.w,
              ),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Pegasus Workflow Manager',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 Pegasus. Tous droits réservés.',
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Se déconnecter'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}
