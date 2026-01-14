import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/project_model.dart';

part 'project_api_service.g.dart';

@RestApi(baseUrl: "https://api.pegasus.com/v1") // Placeholder URL
abstract class ProjectApiService {
  factory ProjectApiService(Dio dio, {String baseUrl}) = _ProjectApiService;

  @GET("/projects")
  Future<List<ProjectModel>> getProjects();

  @POST("/projects")
  Future<void> createProject(@Body() ProjectModel project);

  @PUT("/projects/{id}")
  Future<void> updateProject(@Path("id") String id, @Body() ProjectModel project);

  @DELETE("/projects/{id}")
  Future<void> deleteProject(@Path("id") String id);
}
