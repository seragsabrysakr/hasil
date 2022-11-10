import 'package:dio/dio.dart';
import 'package:hassel/data/model/login_model.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:retrofit/http.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: '')
abstract class AuthServiceClient {
  factory AuthServiceClient(Dio dio, {String baseUrl}) = _AuthServiceClient;
  @MultiPart()
  @POST(AppUrls.login)
  Future<LoginResponseModel> login({
    @Part(name: 'username') required String userName,
    @Part(name: 'password') required String password,
    @Query(AppUrls.consumerKey) required String consumerKey,
    @Query(AppUrls.consumerSecret) required String consumerSecret,
  });
  @GET(AppUrls.userInfo)
  Future<List<UserModel>> getUserInfo({
    @Query( 'email') required String email,
    @Query(AppUrls.consumerKey) required String consumerKey,
    @Query(AppUrls.consumerSecret) required String consumerSecret,
  });
}
