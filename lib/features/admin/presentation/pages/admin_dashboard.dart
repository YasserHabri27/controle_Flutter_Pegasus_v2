import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/theme/app_theme.dart';
import '../../bloc/tasks/tasks_bloc.dart';
import 'package:pegasus_app/features/projects/presentation/bloc/project_bloc.dart'; // Import ProjectBloc
import 'package:pegasus_app/core/widgets/custom_app_bar.dart';
import 'package:pegasus_app/core/widgets/custom_bottom_bar.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';
import './widgets/activity_feed_item_widget.dart';
import './widgets/alert_notification_widget.dart';
import './widgets/quick_action_button_widget.dart';
import './widgets/statistics_card_widget.dart';
import './widgets/system_health_indicator_widget.dart';

/// Tableau de bord administrateur (AdminDashboard).
/// Cette vue offre une supervision complète du système local.
/// Nous y agrégeons les données réelles provenant de Hive (Tâches, Projets)
/// pour fournir des statistiques en temps réel à l'administrateur.
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // ... (variables)

  @override
  void initState() {
    super.initState();
    _loadData(); // Chargement initial des données locales
  }

  /// Déclenche le rechargement des Tâches et Projets depuis leurs BLoCs respectifs.
  /// Cette action mettra à jour l'état global et rafraîchira l'interface utilisateur.
  void _loadData() {
    context.read<TasksBloc>().add(LoadTasks());
    context.read<ProjectBloc>().add(LoadProjects());
  }

  /// Gestion du "Pull-to-Refresh".
  /// Nous simulons un court délai pour une meilleure expérience utilisateur (UX),
  /// puis nous confirmons à l'utilisateur que les données sont à jour.
  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    _loadData();
    await Future.delayed(const Duration(seconds: 1)); // UX delay
    if (mounted) {
      // ...
    }
  }

  // ...

  // --- Statistiques en Temps Réel ---
  // Nous utilisons BlocBuilder pour écouter les changements d'état des Tâches et Projets.
  // Cela nous permet de calculer dynamiquement les KPIs (Key Performance Indicators)
  // sans avoir besoin d'un backend centralisé pour l'instant.
  BlocBuilder<TasksBloc, TasksState>(
    builder: (context, taskState) {
      return BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, projectState) {
          int taskCount = 0;
          int completedTasks = 0;
          int workflowCount = 0;

          if (taskState is TasksLoaded) {
             // ...
          }
                          taskCount = taskState.tasks.length;
                          completedTasks = taskState.tasks
                              .where((t) => t['isCompleted'] == true)
                              .length;
                        }

                        if (projectState is ProjectsLoaded) {
                          workflowCount = projectState.workflows.length;
                        }

                        double completionRate = taskCount > 0 
                            ? (completedTasks / taskCount) * 100 
                            : 0;

                        final statisticsData = [
                          {
                            "title": "Tâches Totales",
                            "value": taskCount.toString(),
                            "trend": "Réel",
                            "isPositive": true,
                            "icon": Icons.task,
                          },
                          {
                            "title": "Taux complétion",
                            "value": "${completionRate.toStringAsFixed(0)}%",
                            "trend": "Calculé",
                            "isPositive": completionRate > 50,
                            "icon": Icons.done_all,
                          },
                          {
                            "title": "Workflows actifs",
                            "value": workflowCount.toString(),
                            "trend": "Réel",
                            "isPositive": true,
                            "icon": Icons.account_tree_outlined,
                          },
                          {
                            "title": "Session Utilisateur",
                            "value": "Actif",
                            "trend": "Local",
                            "isPositive": true,
                            "icon": Icons.person_outline,
                          },
                        ];

                        return Wrap(
                          spacing: 3.w,
                          runSpacing: 2.h,
                          children: statisticsData.map((stat) {
                            return StatisticsCardWidget(
                              title: stat["title"] as String,
                              value: stat["value"] as String,
                              trend: stat["trend"] as String,
                              isPositive: stat["isPositive"] as bool,
                              icon: stat["icon"] as IconData,
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 3.h),

                // Quick Actions Section
                Text(
                  'Actions rapides',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: QuickActionButtonWidget(
                        label: 'Créer Tâche',
                        icon: Icons.add_task,
                        onTap: () => _handleNavigation('/tasks'),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: QuickActionButtonWidget(
                        label: 'Statistiques',
                        icon: Icons.assessment_outlined,
                        onTap: () => _handleNavigation('/global-statistics'),
                        backgroundColor: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                QuickActionButtonWidget(
                  label: 'Gestion des Workflows',
                  icon: Icons.account_tree,
                  onTap: () => _handleNavigation('/workflows'),
                  backgroundColor: AppTheme.getAccentColor(theme.brightness),
                ),

                SizedBox(height: 3.h),

                // System Health Section
                Text(
                  'État du système Local',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                ..._systemHealth.map((health) {
                  return SystemHealthIndicatorWidget(
                    serviceName: health["serviceName"] as String,
                    status: health["status"] as String,
                    isHealthy: health["isHealthy"] as bool,
                    details: health["details"] as String?,
                  );
                }).toList(),

                SizedBox(height: 3.h),

                // Alerts Section
                Text(
                  'Alertes système',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                ..._alerts.map((alert) {
                  return AlertNotificationWidget(
                    title: alert["title"] as String,
                    description: alert["description"] as String,
                    timestamp: alert["timestamp"] as String,
                    icon: alert["icon"] as IconData,
                    alertColor: alert["alertColor"] as Color,
                    onTap: () {},
                  );
                }).toList(),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentRoute: '/admin-dashboard',
        onNavigate: _handleNavigation,
      ),
    );
  }
}
