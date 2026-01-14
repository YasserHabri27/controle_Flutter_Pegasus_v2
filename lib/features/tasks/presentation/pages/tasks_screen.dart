import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import 'package:pegasus_app/core/services/notification_service.dart';
import 'package:pegasus_app/core/services/theme_service.dart';
import '../../bloc/tasks/tasks_bloc.dart';
import 'package:pegasus_app/core/widgets/app_drawer.dart';

import 'package:pegasus_app/core/widgets/custom_bottom_bar.dart';

import 'package:pegasus_app/core/widgets/custom_icon_widget.dart';

import 'package:pegasus_app/core/widgets/loading_shimmer.dart';

import './widgets/empty_state_widget.dart';

import './widgets/filter_bottom_sheet_widget.dart';

import './widgets/task_card_widget.dart';

import './widgets/task_form_widget.dart';

class TasksManagement extends StatefulWidget {
  const TasksManagement({super.key});

  @override
  State<TasksManagement> createState() => _TasksManagementState();
}

class _TasksManagementState extends State<TasksManagement> {
  // UI state (search, filter, etc.)
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'Priority';
  String _filterStatus = 'All';
  bool _isSearching = false;

  // Services
  final ThemeService _themeService = ThemeService();
  final NotificationService _notificationService = NotificationService();

  // Local filtered list
  List<Map<String, dynamic>> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    // LoadTasks event is dispatched from app_routes.dart
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      // Re-filter the tasks from the current BLoC state
      final currentState = context.read<TasksBloc>().state;
      if (currentState is TasksLoaded) {
        _applyFiltersAndSort(currentState.tasks);
      }
    });
  }

  void _applyFiltersAndSort(List<Map<String, dynamic>> allTasks) {
    setState(() {
      _filteredTasks = allTasks.where((task) {
        final matchesSearch = _searchQuery.isEmpty ||
            (task["title"] as String).toLowerCase().contains(_searchQuery) ||
            (task["description"] as String).toLowerCase().contains(_searchQuery);

        final matchesStatus = _filterStatus == 'All' ||
            (_filterStatus == 'Completed' && task["isCompleted"] == true) ||
            (_filterStatus == 'Pending' && task["isCompleted"] == false) ||
            (_filterStatus == 'Overdue' &&
                task["isCompleted"] == false &&
                (task["dueDate"] as DateTime).isBefore(DateTime.now()));

        return matchesSearch && matchesStatus;
      }).toList();

      _filteredTasks.sort((a, b) {
        if (_sortBy == 'Priority') {
          final priorityOrder = {'High': 0, 'Medium': 1, 'Low': 2};
          return (priorityOrder[a["priority"]] ?? 3)
              .compareTo(priorityOrder[b["priority"]] ?? 3);
        } else if (_sortBy == 'Due Date') {
          return (a["dueDate"] as DateTime).compareTo(b["dueDate"] as DateTime);
        } else if (_sortBy == 'Status') {
          return (a["isCompleted"] == b["isCompleted"])
              ? 0
              : (a["isCompleted"] as bool)
                  ? 1
                  : -1;
        }
        return 0;
      });
    });
  }

  Future<void> _onRefresh() async {
    context.read<TasksBloc>().add(LoadTasks());
  }

  void _showFilterSheet(List<Map<String, dynamic>> allTasks) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        currentFilter: _filterStatus,
        taskCounts: _getTaskCounts(allTasks),
        onFilterSelected: (filter) {
          setState(() {
            _filterStatus = filter;
            _applyFiltersAndSort(allTasks);
          });
        },
      ),
    );
  }

  Map<String, int> _getTaskCounts(List<Map<String, dynamic>> allTasks) {
    return {
      'All': allTasks.length,
      'Pending': allTasks.where((t) => t["isCompleted"] == false).length,
      'Completed': allTasks.where((t) => t["isCompleted"] == true).length,
      'Overdue': allTasks
          .where((t) =>
              t["isCompleted"] == false &&
              (t["dueDate"] as DateTime).isBefore(DateTime.now()))
          .length,
    };
  }

  void _showCreateTaskForm() {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => TaskFormWidget(onSave: _createTask),
    // );
  }

  void _showEditTaskForm(Map<String, dynamic> task) {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => TaskFormWidget(
    //     task: task,
    //     onSave: (updatedTask) => _updateTask(task["id"] as String, updatedTask),
    //   ),
    // );
  }
  
  // ... (other methods like _createTask, _updateTask, _deleteTask would dispatch events to BLoC)
  // void _createTask(Map<String, dynamic> taskData) {
  //   context.read<TasksBloc>().add(AddTask(taskData));
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: theme.colorScheme.onPrimary),
                decoration: InputDecoration(
                  hintText: 'Rechercher des tâches...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onPrimary.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              )
            : Row(
                 children: [
                  Image.asset(
                    'assets/images/image-1767396189878.png',
                    width: 8.w,
                    height: 8.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.flight, size: 6.w);
                    },
                  ),
                  SizedBox(width: 2.w),
                  const Text('Gestion des tâches'),
                ],
              ),
        actions: [
           if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              },
            ),
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _isSearching = true),
            ),
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                 final state = context.read<TasksBloc>().state;
                 if (state is TasksLoaded) {
                    _showFilterSheet(state.tasks);
                 }
              },
            ),
          if (!_isSearching)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                if (_notificationService.unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(0.5.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 4.w, minHeight: 4.w),
                      child: Center(
                        child: Text(
                          '${_notificationService.unreadCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      drawer: AppDrawer(
        themeService: _themeService,
        notificationService: _notificationService,
        userName: 'Sophie Martin',
        userEmail: 'sophie.martin@pegasus.com',
        userImageUrl: 'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
      ),
      body: BlocBuilder<TasksBloc, TasksState>(

        builder: (context, state) {

          if (state is TasksLoading) {

            return const TaskListShimmer();

          } else if (state is TasksError) {

            return Center(child: Text('Erreur: ${state.message}'));

          } else if (state is TasksLoaded) {
            // Apply initial filter and sort when tasks are loaded
            WidgetsBinding.instance.addPostFrameCallback((_) {
               if(ModalRoute.of(context)!.isCurrent) {
                  _applyFiltersAndSort(state.tasks);
               }
            });

            if (_filteredTasks.isEmpty) {
              return EmptyStateWidget(
                hasSearchQuery: _searchQuery.isNotEmpty,
                onCreateTask: _showCreateTaskForm,
              );
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: _filteredTasks.length,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemBuilder: (context, index) {

                  final task = _filteredTasks[index];

                  return TweenAnimationBuilder<double>(

                    tween: Tween(begin: 0.0, end: 1.0),

                    duration: Duration(milliseconds: 400 + (index * 50).clamp(0, 500)),

                    curve: Curves.easeOut,

                    builder: (context, value, child) {

                      return Opacity(

                        opacity: value,

                        child: Transform.translate(

                          offset: Offset(0, 20 * (1 - value)),

                          child: child,

                        ),

                      );

                    },

                    child: Padding(

                      padding: EdgeInsets.only(bottom: 1.5.h),

                      child: Slidable(

                        key: ValueKey(task["id"]),

                        // ... Slidable actions

                        child: TaskCardWidget(

                          task: task,

                          onTap: () => _showEditTaskForm(task),

                          onLongPress: () {}, // _showTaskContextMenu(task),

                          onCheckboxChanged: (_) {}, // _toggleTaskCompletion(task["id"] as String),

                        ),

                      ),

                    ),

                  );

                },

              ),

            );
          }
          return const Center(child: Text('Veuillez charger les tâches.'));
        },
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: _showCreateTaskForm,

        backgroundColor: theme.colorScheme.primary,

        child: const Icon(Icons.add),

      ),

      bottomNavigationBar: CustomBottomBar(

        currentIndex: 1,

        onChanged: (index) {

          if (index == 0) {

            Navigator.pushReplacementNamed(context, '/user-dashboard');

          }

        },

      ),

    );

  }

}
