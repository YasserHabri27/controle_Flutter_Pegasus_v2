import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../tasks/presentation/bloc/tasks_bloc.dart';
import '../../projects/presentation/bloc/project_bloc.dart';
import '../../projects/presentation/bloc/project_event.dart';
import '../../projects/presentation/bloc/project_state.dart';
import 'package:pegasus_app/core/widgets/custom_bottom_bar.dart';
import 'package:pegasus_app/core/widgets/loading_shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load fresh data on init
    context.read<TasksBloc>().add(LoadTasks());
    context.read<ProjectBloc>().add(LoadProjects());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, taskState) {
          return BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, projectState) {
              if (taskState is TasksLoading || projectState is ProjectsLoading) {
                 // Only show shimmer if we don't have data loaded yet, 
                 // but normally we might want to check for initial load.
                 // For now, simple shimmer if either is loading.
                 return const DashboardShimmer();
              }
              
              final tasks = (taskState is TasksLoaded) ? taskState.tasks : <Map<String, dynamic>>[];
              final projects = (projectState is ProjectsLoaded) ? projectState.projects : [];

              return _buildDashboardContent(context, tasks, projects.length);
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        currentRoute: '/user-dashboard',
        onNavigate: (route) {
           if (route != '/user-dashboard') {
             Navigator.pushReplacementNamed(context, route);
           }
        },
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, List<Map<String, dynamic>> tasks, int projectCount) {
    // Calculate stats
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t['isCompleted'] == true).length;
    final pendingTasks = tasks.where((t) => t['isCompleted'] == false).length;
    final overdueTasks = tasks.where((t) => 
      t['isCompleted'] == false && (t['dueDate'] as DateTime).isBefore(DateTime.now())
    ).length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aperçu',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(child: _SummaryCard(
                title: 'Tâches Totales',
                value: totalTasks.toString(),
                icon: Icons.assignment,
                color: Colors.blue,
              )),
              SizedBox(width: 3.w),
              Expanded(child: _SummaryCard(
                title: 'Projets Actifs',
                value: projectCount.toString(),
                icon: Icons.account_tree,
                color: Colors.purple,
              )),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(child: _SummaryCard(
                title: 'Tâches Terminées',
                value: completedTasks.toString(),
                icon: Icons.check_circle,
                color: Colors.green,
              )),
              SizedBox(width: 3.w),
              Expanded(child: _SummaryCard(
                title: 'En retard',
                value: overdueTasks.toString(),
                icon: Icons.warning,
                color: Colors.red,
              )),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Progression des Tâches',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 30.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: totalTasks == 0 
            ? const Center(child: Text("Créez des tâches pour voir votre progression"))
            : Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 30,
                      sections: [
                        if (completedTasks > 0)
                        PieChartSectionData(
                          color: Colors.green,
                          value: completedTasks.toDouble(),
                          title: '${((completedTasks/totalTasks)*100).toStringAsFixed(0)}%',
                          radius: 45,
                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        if (pendingTasks > 0)
                        PieChartSectionData(
                          color: Colors.orange,
                          value: pendingTasks.toDouble(),
                          title: '${((pendingTasks/totalTasks)*100).toStringAsFixed(0)}%',
                          radius: 45,
                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        if (overdueTasks > 0)
                        PieChartSectionData(
                          color: Colors.red,
                          value: overdueTasks.toDouble(),
                          title: '${((overdueTasks/totalTasks)*100).toStringAsFixed(0)}%',
                          radius: 45,
                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _LegendItem(color: Colors.green, text: 'Terminées'),
                    SizedBox(height: 1.h),
                    const _LegendItem(color: Colors.orange, text: 'En attente'),
                    if (overdueTasks > 0) ...[
                      SizedBox(height: 1.h),
                      const _LegendItem(color: Colors.red, text: 'En retard'),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 5.w),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 2.w),
        Text(text, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }
}

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingShimmer.rectangular(height: 3.h, width: 30.w),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(child: LoadingShimmer.rectangular(height: 12.h)),
              SizedBox(width: 3.w),
              Expanded(child: LoadingShimmer.rectangular(height: 12.h)),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(child: LoadingShimmer.rectangular(height: 12.h)),
              SizedBox(width: 3.w),
              Expanded(child: LoadingShimmer.rectangular(height: 12.h)),
            ],
          ),
           SizedBox(height: 4.h),
          LoadingShimmer.rectangular(height: 3.h, width: 40.w),
          SizedBox(height: 2.h),
          LoadingShimmer.rectangular(height: 25.h),
        ],
      ),
    );
  }
}
