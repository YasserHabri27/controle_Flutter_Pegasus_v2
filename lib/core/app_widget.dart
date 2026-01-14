import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../features/projects/presentation/bloc/project_bloc.dart';
import '../features/projects/presentation/bloc/project_event.dart'; // For LoadProjects
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'service_locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<TasksBloc>()..add(LoadTasks()),
        ),
        BlocProvider(
          create: (context) => di.sl<ProjectBloc>()..add(LoadProjects()),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Pegasus',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.splashScreen,
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}