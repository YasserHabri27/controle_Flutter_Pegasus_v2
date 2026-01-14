import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_app_bar.dart';
import '../package:pegasus_app/core/widgets/custom_bottom_bar.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';
import './widgets/bulk_action_bar_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/user_card_widget.dart';
import './widgets/user_detail_dialog_widget.dart';
import './widgets/user_search_bar_widget.dart';

/// User Management screen for administrators to oversee and control user accounts
class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  bool _isSelectionMode = false;
  final Set<int> _selectedUsers = {};
  List<Map<String, dynamic>> _filteredUsers = [];
  bool _isLoading = false;

  final List<Map<String, dynamic>> _allUsers = [
    {
      'id': 1,
      'name': 'Sophie Martin',
      'email': 'sophie.martin@example.fr',
      'role': 'Utilisateur',
      'status': 'Actif',
      'lastActive': '03/01/2026 08:30',
      'registrationDate': '15/12/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'une femme aux cheveux bruns courts portant un chemisier blanc',
      'tasksCreated': 45,
      'tasksCompleted': 38,
      'activeWorkflows': 3,
      'completionRate': 84,
      'adminNotes':
          'Utilisateur actif et productif. Excellente gestion des tâches.',
    },
    {
      'id': 2,
      'name': 'Thomas Dubois',
      'email': 'thomas.dubois@example.fr',
      'role': 'Admin',
      'status': 'Actif',
      'lastActive': '03/01/2026 07:45',
      'registrationDate': '01/11/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'un homme aux cheveux blonds portant une chemise bleue',
      'tasksCreated': 120,
      'tasksCompleted': 105,
      'activeWorkflows': 8,
      'completionRate': 88,
      'adminNotes': 'Administrateur principal. Gère les workflows complexes.',
    },
    {
      'id': 3,
      'name': 'Marie Lefebvre',
      'email': 'marie.lefebvre@example.fr',
      'role': 'Utilisateur',
      'status': 'Suspendu',
      'lastActive': '28/12/2025 14:20',
      'registrationDate': '10/10/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'une femme aux cheveux roux portant des lunettes',
      'tasksCreated': 22,
      'tasksCompleted': 15,
      'activeWorkflows': 1,
      'completionRate': 68,
      'adminNotes': 'Compte suspendu pour inactivité prolongée.',
    },
    {
      'id': 4,
      'name': 'Lucas Bernard',
      'email': 'lucas.bernard@example.fr',
      'role': 'Utilisateur',
      'status': 'Nouveau',
      'lastActive': '02/01/2026 16:30',
      'registrationDate': '02/01/2026',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'un jeune homme aux cheveux noirs portant un t-shirt gris',
      'tasksCreated': 3,
      'tasksCompleted': 1,
      'activeWorkflows': 1,
      'completionRate': 33,
      'adminNotes':
          'Nouvel utilisateur. En phase de découverte de l\'application.',
    },
    {
      'id': 5,
      'name': 'Emma Moreau',
      'email': 'emma.moreau@example.fr',
      'role': 'Utilisateur',
      'status': 'Actif',
      'lastActive': '03/01/2026 06:15',
      'registrationDate': '20/11/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'une femme aux cheveux châtains longs portant une veste noire',
      'tasksCreated': 67,
      'tasksCompleted': 59,
      'activeWorkflows': 5,
      'completionRate': 88,
      'adminNotes':
          'Utilisateur très actif. Utilise régulièrement les workflows.',
    },
    {
      'id': 6,
      'name': 'Hugo Petit',
      'email': 'hugo.petit@example.fr',
      'role': 'Admin',
      'status': 'Actif',
      'lastActive': '03/01/2026 08:00',
      'registrationDate': '05/09/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'un homme aux cheveux bruns courts portant une chemise blanche',
      'tasksCreated': 98,
      'tasksCompleted': 92,
      'activeWorkflows': 6,
      'completionRate': 94,
      'adminNotes': 'Administrateur secondaire. Gère le support utilisateur.',
    },
    {
      'id': 7,
      'name': 'Chloé Roux',
      'email': 'chloe.roux@example.fr',
      'role': 'Utilisateur',
      'status': 'Actif',
      'lastActive': '02/01/2026 19:45',
      'registrationDate': '18/10/2025',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'une femme aux cheveux blonds portant un pull rose',
      'tasksCreated': 34,
      'tasksCompleted': 28,
      'activeWorkflows': 2,
      'completionRate': 82,
      'adminNotes': 'Utilisateur régulier. Bonne organisation des tâches.',
    },
    {
      'id': 8,
      'name': 'Nathan Girard',
      'email': 'nathan.girard@example.fr',
      'role': 'Utilisateur',
      'status': 'Nouveau',
      'lastActive': '03/01/2026 05:30',
      'registrationDate': '01/01/2026',
      'avatar':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      'avatarLabel':
          'Photo de profil d\'un homme aux cheveux châtains portant une veste en jean',
      'tasksCreated': 5,
      'tasksCompleted': 2,
      'activeWorkflows': 1,
      'completionRate': 40,
      'adminNotes': 'Nouvel utilisateur. Premiers pas dans l\'application.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredUsers = List.from(_allUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final matchesSearch =
            _searchController.text.isEmpty ||
            (user['name'] as String).toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            (user['email'] as String).toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            (user['role'] as String).toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );

        final matchesFilter =
            _selectedFilter == 'all' ||
            (_selectedFilter == 'active' && user['status'] == 'Actif') ||
            (_selectedFilter == 'suspended' && user['status'] == 'Suspendu') ||
            (_selectedFilter == 'new' && user['status'] == 'Nouveau') ||
            (_selectedFilter == 'user' && user['role'] == 'Utilisateur') ||
            (_selectedFilter == 'admin' && user['role'] == 'Admin');

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  Future<void> _refreshUsers() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Liste des utilisateurs mise à jour'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleSelectionMode(int userId) {
    setState(() {
      if (_isSelectionMode) {
        if (_selectedUsers.contains(userId)) {
          _selectedUsers.remove(userId);
          if (_selectedUsers.isEmpty) {
            _isSelectionMode = false;
          }
        } else {
          _selectedUsers.add(userId);
        }
      } else {
        _isSelectionMode = true;
        _selectedUsers.add(userId);
      }
    });
  }

  void _cancelSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedUsers.clear();
    });
  }

  void _showUserDetail(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => UserDetailDialogWidget(
        user: user,
        onEditDetails: () {
          Navigator.of(context).pop();
          _showSnackBar('Modification des détails de ${user['name']}');
        },
        onChangeRole: () {
          Navigator.of(context).pop();
          _showConfirmationDialog(
            'Changer le rôle',
            'Voulez-vous changer le rôle de ${user['name']} ?',
            () => _showSnackBar('Rôle modifié pour ${user['name']}'),
          );
        },
        onViewActivityLog: () {
          Navigator.of(context).pop();
          _showSnackBar('Journal d\'activité de ${user['name']}');
        },
        onAccountSettings: () {
          Navigator.of(context).pop();
          _showSnackBar('Paramètres du compte de ${user['name']}');
        },
      ),
    );
  }

  void _showConfirmationDialog(
    String title,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  void _exportUsers() async {
    final selectedUsersList = _allUsers
        .where((user) => _selectedUsers.contains(user['id']))
        .toList();

    final csvContent = StringBuffer();
    csvContent.writeln('Nom,Email,Rôle,Statut,Dernière activité');

    for (final user in selectedUsersList) {
      csvContent.writeln(
        '${user['name']},${user['email']},${user['role']},${user['status']},${user['lastActive']}',
      );
    }

    await Share.share(
      csvContent.toString(),
      subject:
          'Export des utilisateurs - ${DateTime.now().toString().split(' ')[0]}',
    );

    _showSnackBar('${selectedUsersList.length} utilisateur(s) exporté(s)');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gestion des utilisateurs',
        variant: AppBarVariant.standard,
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _refreshUsers,
            tooltip: 'Actualiser',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'download',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () {
              if (_selectedUsers.isNotEmpty) {
                _exportUsers();
              } else {
                _showSnackBar('Sélectionnez des utilisateurs à exporter');
              }
            },
            tooltip: 'Exporter',
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              UserSearchBarWidget(
                controller: _searchController,
                onChanged: (value) => _filterUsers(),
                onClear: () {
                  _searchController.clear();
                  _filterUsers();
                },
              ),
              FilterChipsWidget(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() => _selectedFilter = filter);
                  _filterUsers();
                },
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _filteredUsers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconWidget(
                              iconName: 'person_off',
                              color: theme.colorScheme.onSurfaceVariant,
                              size: 48,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Aucun utilisateur trouvé',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshUsers,
                        child: ListView.builder(
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            final isSelected = _selectedUsers.contains(
                              user['id'],
                            );

                            return UserCardWidget(
                              user: user,
                              isSelected: isSelected,
                              isSelectionMode: _isSelectionMode,
                              onTap: () {
                                if (_isSelectionMode) {
                                  _toggleSelectionMode(user['id'] as int);
                                } else {
                                  _showUserDetail(user);
                                }
                              },
                              onLongPress: () =>
                                  _toggleSelectionMode(user['id'] as int),
                              onCheckboxChanged: (value) =>
                                  _toggleSelectionMode(user['id'] as int),
                              onViewProfile: () => _showUserDetail(user),
                              onSendMessage: () => _showSnackBar(
                                'Message envoyé à ${user['name']}',
                              ),
                              onGenerateReport: () => _showSnackBar(
                                'Rapport généré pour ${user['name']}',
                              ),
                              onSuspend: () => _showConfirmationDialog(
                                'Suspendre le compte',
                                'Voulez-vous suspendre le compte de ${user['name']} ?',
                                () => _showSnackBar(
                                  'Compte de ${user['name']} suspendu',
                                ),
                              ),
                              onResetPassword: () => _showConfirmationDialog(
                                'Réinitialiser le mot de passe',
                                'Voulez-vous réinitialiser le mot de passe de ${user['name']} ?',
                                () => _showSnackBar(
                                  'Mot de passe réinitialisé pour ${user['name']}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
          if (_isSelectionMode)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BulkActionBarWidget(
                selectedCount: _selectedUsers.length,
                onDelete: () => _showConfirmationDialog(
                  'Supprimer les utilisateurs',
                  'Voulez-vous supprimer ${_selectedUsers.length} utilisateur(s) ?',
                  () {
                    _showSnackBar(
                      '${_selectedUsers.length} utilisateur(s) supprimé(s)',
                    );
                    _cancelSelection();
                  },
                ),
                onSuspend: () => _showConfirmationDialog(
                  'Suspendre les utilisateurs',
                  'Voulez-vous suspendre ${_selectedUsers.length} utilisateur(s) ?',
                  () {
                    _showSnackBar(
                      '${_selectedUsers.length} utilisateur(s) suspendu(s)',
                    );
                    _cancelSelection();
                  },
                ),
                onActivate: () => _showConfirmationDialog(
                  'Activer les utilisateurs',
                  'Voulez-vous activer ${_selectedUsers.length} utilisateur(s) ?',
                  () {
                    _showSnackBar(
                      '${_selectedUsers.length} utilisateur(s) activé(s)',
                    );
                    _cancelSelection();
                  },
                ),
                onExport: _exportUsers,
                onCancel: _cancelSelection,
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentRoute: '/user-management',
        onNavigate: (route) {
          if (route != '/user-management') {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }
}
