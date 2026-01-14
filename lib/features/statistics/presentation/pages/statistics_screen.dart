import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/widgets/custom_app_bar.dart';
import 'package:pegasus_app/core/widgets/custom_bottom_bar.dart';
import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';
import './widgets/achievement_badge_widget.dart';
import './widgets/chart_section_widget.dart';
import './widgets/metrics_card_widget.dart';
import './widgets/productivity_heatmap_widget.dart';
import './widgets/workflow_progress_widget.dart';

/// Statistics screen presenting comprehensive productivity analytics
/// with interactive visualizations optimized for mobile viewing
class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDateRange = 'Cette semaine';
  String _selectedFilter = 'Toutes';

  // Mock data for metrics
  final List<Map<String, dynamic>> _metricsData = [
    {
      'title': 'Tâches complétées',
      'value': '18',
      'trend': '+12%',
      'isPositive': true,
      'icon': Icons.task_alt,
    },
    {
      'title': 'Taux de complétion',
      'value': '85%',
      'trend': '+5%',
      'isPositive': true,
      'icon': Icons.trending_up,
    },
    {
      'title': 'Série de productivité',
      'value': '7 jours',
      'trend': null,
      'isPositive': true,
      'icon': Icons.local_fire_department,
    },
    {
      'title': 'Temps moyen',
      'value': '2.5h',
      'trend': '-15min',
      'isPositive': true,
      'icon': Icons.timer,
    },
  ];

  // Mock data for workflows
  final List<Map<String, dynamic>> _workflowsData = [
    {
      'name': 'Projet de recherche',
      'progress': 75.0,
      'tasksCompleted': 15,
      'totalTasks': 20,
    },
    {
      'name': 'Développement application',
      'progress': 60.0,
      'tasksCompleted': 12,
      'totalTasks': 20,
    },
    {
      'name': 'Révisions examens',
      'progress': 90.0,
      'tasksCompleted': 18,
      'totalTasks': 20,
    },
    {
      'name': 'Préparation présentation',
      'progress': 45.0,
      'tasksCompleted': 9,
      'totalTasks': 20,
    },
  ];

  // Mock data for achievements
  final List<Map<String, dynamic>> _achievementsData = [
    {
      'title': 'Première tâche',
      'description': 'Complétez votre première tâche',
      'icon': Icons.emoji_events,
      'isUnlocked': true,
      'unlockedDate': '15/12/2025',
    },
    {
      'title': 'Série de 7 jours',
      'description': 'Complétez des tâches pendant 7 jours consécutifs',
      'icon': Icons.local_fire_department,
      'isUnlocked': true,
      'unlockedDate': '28/12/2025',
    },
    {
      'title': '50 tâches',
      'description': 'Complétez 50 tâches au total',
      'icon': Icons.star,
      'isUnlocked': false,
      'unlockedDate': null,
    },
    {
      'title': 'Maître du workflow',
      'description': 'Complétez 5 workflows',
      'icon': Icons.workspace_premium,
      'isUnlocked': false,
      'unlockedDate': null,
    },
  ];

  // Mock data for heatmap
  final Map<DateTime, int> _activityData = {
    DateTime(2026, 1, 1): 5,
    DateTime(2026, 1, 2): 8,
    DateTime(2026, 1, 3): 3,
    DateTime(2025, 12, 28): 7,
    DateTime(2025, 12, 29): 4,
    DateTime(2025, 12, 30): 9,
    DateTime(2025, 12, 31): 6,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Statistiques',
        variant: AppBarVariant.standard,
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'share',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _handleExport,
            tooltip: 'Exporter',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'filter_list',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _showFilterOptions,
            tooltip: 'Filtrer',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateRangeSelector(theme),
          _buildTabBar(theme),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(theme),
                _buildChartsTab(theme),
                _buildAchievementsTab(theme),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentRoute: '/statistics',
        onNavigate: (route) {
          if (route != '/statistics') {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }

  Widget _buildDateRangeSelector(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: _showDateRangePicker,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'calendar_today',
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          _selectedDateRange,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CustomIconWidget(
                      iconName: 'arrow_drop_down',
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
        indicatorColor: theme.colorScheme.primary,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Vue d\'ensemble'),
          Tab(text: 'Graphiques'),
          Tab(text: 'Succès'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Métriques clés',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 3.w,
            runSpacing: 2.h,
            children: _metricsData.map((metric) {
              return MetricsCardWidget(
                title: metric['title'] as String,
                value: metric['value'] as String,
                trend: metric['trend'] as String?,
                isPositiveTrend: metric['isPositive'] as bool,
                icon: metric['icon'] as IconData,
              );
            }).toList(),
          ),
          SizedBox(height: 3.h),
          WorkflowProgressWidget(workflows: _workflowsData),
          SizedBox(height: 3.h),
          ProductivityHeatmapWidget(activityData: _activityData),
        ],
      ),
    );
  }

  Widget _buildChartsTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChartSectionWidget(
            title: 'Tendances de complétion',
            chartData: [],
            chartType: ChartType.line,
          ),
          SizedBox(height: 3.h),
          const ChartSectionWidget(
            title: 'Progression des workflows',
            chartData: [],
            chartType: ChartType.bar,
          ),
          SizedBox(height: 3.h),
          const ChartSectionWidget(
            title: 'Répartition par priorité',
            chartData: [],
            chartType: ChartType.pie,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vos succès',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 3.w,
            runSpacing: 2.h,
            children: _achievementsData.map((achievement) {
              return AchievementBadgeWidget(
                title: achievement['title'] as String,
                description: achievement['description'] as String,
                icon: achievement['icon'] as IconData,
                isUnlocked: achievement['isUnlocked'] as bool,
                unlockedDate: achievement['unlockedDate'] as String?,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showDateRangePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sélectionner la période',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              ...[
                'Aujourd\'hui',
                'Cette semaine',
                'Ce mois',
                'Ce trimestre',
                'Cette année',
              ].map((range) {
                return ListTile(
                  title: Text(range),
                  trailing: _selectedDateRange == range
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: theme.colorScheme.primary,
                          size: 24,
                        )
                      : null,
                  onTap: () {
                    setState(() => _selectedDateRange = range);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtrer par',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              ...[
                'Toutes',
                'Priorité haute',
                'Priorité moyenne',
                'Priorité basse',
                'Par workflow',
              ].map((filter) {
                return ListTile(
                  title: Text(filter),
                  trailing: _selectedFilter == filter
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: theme.colorScheme.primary,
                          size: 24,
                        )
                      : null,
                  onTap: () {
                    setState(() => _selectedFilter = filter);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _handleExport() {
    final exportData =
        '''
Statistiques Pegasus - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}

MÉTRIQUES CLÉS
- Tâches complétées: 18 (+12%)
- Taux de complétion: 85% (+5%)
- Série de productivité: 7 jours
- Temps moyen: 2.5h (-15min)

WORKFLOWS
- Projet de recherche: 75% (15/20 tâches)
- Développement application: 60% (12/20 tâches)
- Révisions examens: 90% (18/20 tâches)
- Préparation présentation: 45% (9/20 tâches)

SUCCÈS DÉBLOQUÉS
✓ Première tâche (15/12/2025)
✓ Série de 7 jours (28/12/2025)

Généré par Pegasus Workflow Manager
''';

    Share.share(exportData, subject: 'Mes statistiques Pegasus');
  }
}
