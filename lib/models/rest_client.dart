import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../helpers/api.dart';
import 'gnews/gnews_result.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "this url will be ignored if baseUrl is passed")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Api.search)
  Future<GnewsResult> getArticlesBySearch(@Query("token") String token,
      {@Query("q") String? query,
      @Query("lang") String? language,
      @Query("country") String? country,
      @Query("max") int? max,
      @Query("in") String? searchIn,
      @Query("from") String? from,
      @Query("to") String? to,
      @Query("sortby") String? sortBy});

  @GET(Api.topHeadlines)
  Future<GnewsResult> getTopHeadlines(
    @Query("token") String token, {
    @Query("topic") String? topic,
    @Query("lang") String? language,
    @Query("country") String? country,
  });
}
