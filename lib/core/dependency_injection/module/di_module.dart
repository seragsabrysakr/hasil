import 'package:dio/dio.dart';
import 'package:hassel/data/storage/aurh/auth_api_services.dart';
import 'package:hassel/data/storage/home/home_api_services.dart';
import 'package:hassel/data/storage/products/products_api_services.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DIModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  AuthServiceClient getAuthServiceClient(Dio client) =>
      AuthServiceClient(client);
  HomeServiceClient getCategoryServiceClient(Dio client) =>
      HomeServiceClient(client);
  ProductsServiceClient getProductsServiceClient(Dio client) =>
      ProductsServiceClient(client);
}
