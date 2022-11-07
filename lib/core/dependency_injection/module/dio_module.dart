import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '/../shared/app_utils/app_strings.dart';
import '../../../shared/app_utils/app_constants.dart';
import '../../../shared/app_utils/app_prefs.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCEPT_Language = "Accept-Language";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

@module
abstract class DioModule {
  @preResolve
  @factoryMethod
  Future<Dio> getDio(AppPreferences _preferences) async {
    Dio dio = Dio();

    // String language = await _appPreferences.getAppLanguage();

    dio.updateHeader(_preferences);

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) {
            log(object.toString());
          }));
    }

    return dio;
  }
}

extension DioHeader on Dio {
  void updateHeader(AppPreferences _preferences) {
    var token = _preferences.getData(AppPreferences.userToken, "");
    Map<String, String> headers = {
      // 'Cookie':
      //     'wp_cocart_session_166687e8b7f2b766f1c195c097920477=1%7C%7C1667819445%7C%7C1667733045%7C%7Cef2607b75bcd527ea966aae5e1e8368b',
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      if (token != '') AUTHORIZATION: token,
      ACCEPT_Language:
          _preferences.getData(AppPreferences.lang, AppStrings.defaultLanguage),
      // DEFAULT_LANGUAGE: language
    };

    options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: headers,
        receiveTimeout: AppConstants.apiTimeOut,
        sendTimeout: AppConstants.apiTimeOut);
  }
}
