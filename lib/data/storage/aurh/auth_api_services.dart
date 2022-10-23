import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';


part 'auth_api_services.g.dart';

@RestApi(baseUrl: '')
abstract class AuthServiceClient {
  factory AuthServiceClient(Dio dio, {String baseUrl}) =
  _AuthServiceClient;
}
