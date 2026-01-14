import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/task_model.dart';

part 'task_api_service.g.dart';

@RestApi(baseUrl: "https://api.pegasus.com/v1") // Placeholder URL
abstract class TaskApiService {
  factory TaskApiService(Dio dio, {String baseUrl}) = _TaskApiService;

  @GET("/tasks")
  Future<List<TaskModel>> getTasks();

  @POST("/tasks")
  Future<void> createTask(@Body() TaskModel task);

  @PUT("/tasks/{id}")
  Future<void> updateTask(@Path("id") String id, @Body() TaskModel task);

  @DELETE("/tasks/{id}")
  Future<void> deleteTask(@Path("id") String id);
}
