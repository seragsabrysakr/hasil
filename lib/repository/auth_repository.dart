import 'package:dartz/dartz.dart';
import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/core/data/network/save_api.dart';
import 'package:hassel/data/model/login_model.dart';
import 'package:hassel/data/storage/aurh/auth_api_services.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRepository {
  final AuthServiceClient _appServiceClient;
  final SafeApi safeApi;
  final AppPreferences appPreferences;

  AuthRepository(
    this._appServiceClient,
    this.safeApi,
    this.appPreferences,
  );

  Future<Either<Failure, LoginResponseModel>> login(
      {required String userName, required String password}) async {
    Future<Either<Failure, LoginResponseModel>> data = safeApi.call(
        apiCall: _appServiceClient.login(
            consumerKey: AppUrls.consumerKeyValue,
            consumerSecret: AppUrls.consumerSecretValue,
            userName: userName,
            password: password));
    return data;
  }
}
