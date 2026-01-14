import 'package:flutter/material.dart';
import '../../features/statistics/presentation/pages/statistics_screen.dart';
import '../../features/admin/presentation/pages/user_management/user_management_screen.dart';
import '../../features/profile/presentation/pages/profile_settings.dart';
import '../../features/admin/presentation/pages/global_statistics/global_statistics_screen.dart';
import '../../features/projects/presentation/pages/project_list_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/tasks/presentation/pages/tasks_screen.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash';
  static const String statistics = '/statistics';
  static const String userManagement = '/user-management';
  static const String profileSettings = '/profile-settings';
  static const String globalStatistics = '/global-statistics';
  static const String workflows = '/workflows'; // Keep route name for compatibility or rename to projects? Better to keep route name stable or rename if fully refactoring. Let's keep /workflows but map to ProjectListPage.
  static const String projects = '/projects'; // Add new route name
  static const String adminDashboard = '/admin-dashboard';
  static const String userDashboard = '/user-dashboard';
  static const String tasks = '/tasks';


  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const AdminDashboard(), // Should this be Splash? usually initial is splash. But existing code had initial -> AdminDashboard. I will leave initial as is but app_widget uses splashScreen.
    splashScreen: (context) => const SplashScreen(),
    statistics: (context) => const Statistics(),
    userManagement: (context) => const UserManagement(),
    profileSettings: (context) => const ProfileSettings(),
    globalStatistics: (context) => const GlobalStatistics(),
    workflows: (context) => const ProjectListPage(),
    projects: (context) => const ProjectListPage(),
    adminDashboard: (context) => const AdminDashboard(),
    userDashboard: (context) => const DashboardScreen(),
    tasks: (context) => const TasksManagement(),
  };
}