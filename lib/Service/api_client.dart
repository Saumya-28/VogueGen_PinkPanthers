import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../model/RecommendationResponse.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://17e3-49-37-34-146.ngrok-free.app/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/recommend")
  Future<RecommendationResponse> getRecommendations(
    @Query("category") String category,
    @Query("subcategory") String subcategory,
    @Query("item") String item,
  );
}

@JsonSerializable()
class RecommendationResponse {
  final List<String> recommendations;

  RecommendationResponse({required this.recommendations});

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationResponseToJson(this);
}

Dio dio = Dio();
ApiClient apiClient = ApiClient(dio);
