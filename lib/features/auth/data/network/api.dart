import 'package:hassel/shared/app_utils/app_constants.dart';
import 'package:hassel/core/data/response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:hassel/features/auth/data/responce/entity.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ServiceClient {
  factory ServiceClient(Dio dio, {String baseUrl}) = _ServiceClient;

  @GET("api/item-categories")
  Future<BaseResponse<UserEntity>> login();
}
