import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/auth_usecases.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

import '../features/tasks/data/datasources/local/task_local_datasource.dart';
import '../features/tasks/data/datasources/remote/task_api_service.dart';
import '../features/tasks/data/datasources/remote/task_remote_datasource.dart';
import '../features/tasks/data/repositories/task_repository_impl.dart';
import '../features/tasks/domain/repositories/task_repository.dart';
import '../features/tasks/domain/usecases/task_usecases.dart';
import '../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../features/tasks/data/models/task_model.dart';

import '../features/projects/data/models/project_model.dart';
import '../features/projects/data/datasources/local/project_local_datasource.dart';
import '../features/projects/data/datasources/remote/project_api_service.dart';
import '../features/projects/data/datasources/remote/project_remote_datasource.dart';
import '../features/projects/data/repositories/project_repository_impl.dart';
import '../features/projects/domain/repositories/project_repository.dart';
import '../features/projects/domain/usecases/project_usecases.dart';
import '../features/projects/presentation/bloc/project_bloc.dart';

final GetIt sl = GetIt.instance;

// Configuration de l'API REST
const String kBaseUrl = 'https://api.pegasus.com/v1'; 

/// Initialisation de l'injection de dépendances (Service Locator).
Future<void> init() async {
  // --- Externes ---
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // --- Initialisation de Hive ---
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());
  
  await Hive.openBox<TaskModel>('tasksBox');
  await Hive.openBox<ProjectModel>('projectsBox');

  sl.registerLazySingleton(() => sharedPreferences);
  
  // --- Client HTTP (Dio) ---
  sl.registerLazySingleton(() {
    final dio = Dio(BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  });

  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // --- Auth ---
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));

  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        logoutUser: sl(),
        checkAuthStatus: sl(),
      ));

  // --- Tasks ---
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<TaskApiService>(
    () => TaskApiService(sl()),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  sl.registerFactory(() => TasksBloc(
        getTasks: sl(),
        addTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
      ));

  // --- Projects ---
  sl.registerLazySingleton<ProjectLocalDataSource>(
    () => ProjectLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProjectApiService>(
    () => ProjectApiService(sl()),
  );
  sl.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetProjects(sl()));
  sl.registerLazySingleton(() => CreateProject(sl()));
  sl.registerLazySingleton(() => UpdateProject(sl()));
  sl.registerLazySingleton(() => DeleteProject(sl()));

  sl.registerFactory(() => ProjectBloc(
        getProjects: sl(),
        createProject: sl(),
        updateProject: sl(),
      ));
}
