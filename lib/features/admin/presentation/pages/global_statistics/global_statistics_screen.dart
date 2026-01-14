import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/widgets/custom_app_bar.dart';
import 'package:pegasus_app/core/widgets/custom_bottom_bar.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';
import '../../bloc/tasks/tasks_bloc.dart';
import 'package:pegasus_app/features/projects/presentation/bloc/project_bloc.dart';
// Widgets
import './widgets/alert_system_widget.dart';
import './widgets/executive_summary_card_widget.dart';
import './widgets/feature_usage_card_widget.dart';
import './widgets/metric_chart_card_widget.dart';
import './widgets/performance_benchmark_widget.dart';
import './widgets/user_adoption_funnel_widget.dart';

/// Écran des Statistiques Globales.
/// Nous présentons ici une vision macroscopique de l'activité.
/// Les graphiques et résumés sont alimentés par les données locales Hive,
/// permettant une analyse précise même sans connexion serveur active.
class GlobalStatistics extends StatefulWidget {
  const GlobalStatistics({super.key});

  @override
  State<GlobalStatistics> createState() => _GlobalStatisticsState();
}

class _GlobalStatisticsState extends State<GlobalStatistics> {
  String _selectedDateRange = 'Données Locales (Hive)';
  bool _isRefreshing = false;

  final List<Map<String, dynamic>> _userRoleData = [
    {'label': 'Current User', 'value': 100},
  ];

  final List<Map<String, dynamic>> _userEngagementData = [
    {'label': 'S 1', 'value': 10},
    {'label': 'S 2', 'value': 25},
    {'label': 'S 3', 'value': 18},
    {'label': 'S 4', 'value': 40},
  ];

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    context.read<TasksBloc>().add(LoadTasks());
    context.read<ProjectBloc>().add(LoadProjects());
    
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Données  actualisées depuis Hive')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Statistiques globales',
        variant: AppBarVariant.standard,
        leading: IconButton(
          icon: CustomIconWidget(iconName: 'arrow_back', color: theme.colorScheme.onSurface, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.primary))
                : CustomIconWidget(iconName: 'refresh', color: theme.colorScheme.onSurface, size: 24),
            onPressed: _isRefreshing ? null : _handleRefresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateRangeSelector(theme),
              SizedBox(height: 2.h),

              // --- Consommation des Données Réelles ---
              // Nous imbriquons les BlocBuilders pour croiser les données des Tâches et des Workflows.
              // Cette approche nous permet de générer des graphiques combinés (ex: Charge de travail globale).
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, taskState) {
                  return BlocBuilder<ProjectBloc, ProjectState>(
                    builder: (context, projectState) {
                       int taskCount = 0;
                       int completedTasks = 0;
                       int workflowCount = 0;
                       
                       if (taskState is TasksLoaded) {
                         taskCount = taskState.tasks.length;
                         completedTasks = taskState.tasks.where((t) => t['isCompleted'] == true).length;
                       }
                       if (projectState is ProjectsLoaded) {
                         workflowCount = projectState.workflows.length;
                       }
                       
                       int highPriority = 0;
                       int mediumPriority = 0;
                       int lowPriority = 0;
                       
                       if (taskState is TasksLoaded) {
                         highPriority = taskState.tasks.where((t) => t['priority'] == 'High').length;
                         mediumPriority = taskState.tasks.where((t) => t['priority'] == 'Medium').length;
                         lowPriority = taskState.tasks.where((t) => t['priority'] == 'Low').length;
                       }
                       
                        final List<Map<String, dynamic>> priorityChartData = [
                          {'label': 'Haute', 'value': highPriority},
                          {'label': 'Moyenne', 'value': mediumPriority},
                          {'label': 'Basse', 'value': lowPriority},
                        ];

                       final executiveSummaryData = [
                          {
                            'title': 'Tâches Totales',
                            'value': taskCount.toString(),
                            'subtitle': 'Dans la base locale',
                            'icon': Icons.task,
                            'iconColor': const Color(0xFF2563EB),
                            'trend': null,
                            'isPositiveTrend': true,
                          },
                          {
                            'title': 'Tâches Terminées',
                            'value': completedTasks.toString(),
                            'subtitle': 'Accomplies',
                            'icon': Icons.check_circle,
                            'iconColor': const Color(0xFF059669),
                            'trend': null,
                            'isPositiveTrend': true,
                          },
                          {
                            'title': 'Flux actifs',
                            'value': workflowCount.toString(),
                            'subtitle': 'Définis',
                            'icon': Icons.account_tree,
                            'iconColor': const Color(0xFF7C3AED),
                            'trend': null,
                            'isPositiveTrend': true,
                          },
                       ];

                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                            _buildExecutiveSummary(theme, executiveSummaryData),
                            SizedBox(height: 2.h),
                            
                            MetricChartCardWidget(
                              title: 'Répartition par Priorité (Réel)',
                              subtitle: 'Basé sur vos tâches actuelles',
                              chartData: priorityChartData,
                              chartType: 'pie',
                            ),
                         ],
                       );
                    },
                  );
                },
              ),

              SizedBox(height: 1.h),

              MetricChartCardWidget(
                title: 'Activité Serveur (Simulation)',
                subtitle: 'Charge simulée',
                chartData: _userEngagementData,
                chartType: 'line',
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentRoute: '/global-statistics',
        onNavigate: (route) {
          if (route != '/global-statistics') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }

  Widget _buildDateRangeSelector(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          CustomIconWidget(iconName: 'storage', color: theme.colorScheme.primary, size: 20),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              _selectedDateRange,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutiveSummary(ThemeData theme, List<Map<String, dynamic>> data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Résumé (Données Hive)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 1.5.h),
          Wrap(
            spacing: 3.w,
            runSpacing: 2.h,
            children: data.map((d) => ExecutiveSummaryCardWidget(
              title: d['title'] as String,
              value: d['value'] as String,
              subtitle: d['subtitle'] as String,
              icon: d['icon'] as IconData,
              iconColor: d['iconColor'] as Color,
              trend: d['trend'] as String?,
              isPositiveTrend: d['isPositiveTrend'] as bool,
            )).toList(),
          ),
        ],
      ),
    );
  }
}
