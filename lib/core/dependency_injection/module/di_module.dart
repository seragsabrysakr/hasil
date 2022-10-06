import 'package:dio/dio.dart';
import 'package:hassel/features/auth/data/network/api.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DIModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  ServiceClient getServiceClient(Dio client) => ServiceClient(client);
}
