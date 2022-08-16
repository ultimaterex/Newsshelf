import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';


@RestApi(baseUrl: "this url will be ignored if baseUrl is passed")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  

}
