import 'package:dartz/dartz.dart';
import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/core/data/network/save_api.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/data/storage/home/home_api_services.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRepository {
  final HomeServiceClient _appServiceClient;
  final SafeApi safeApi;
  final AppPreferences appPreferences;

  HomeRepository(
    this._appServiceClient,
    this.safeApi,
    this.appPreferences,
  );

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    Future<Either<Failure, List<CategoryModel>>> data = safeApi.call(
        apiCall: _appServiceClient.getCategories(
      consumerKey: AppUrls.consumerKeyValue,
      consumerSecret: AppUrls.consumerSecretValue,
    ));
    return data;
  }

  Future<Either<Failure, List<ProductModel>>> geAllProducts() async {
    Future<Either<Failure, List<ProductModel>>> data = safeApi.call(
        apiCall: _appServiceClient.geAllProducts(
      consumerKey: AppUrls.consumerKeyValue,
      consumerSecret: AppUrls.consumerSecretValue,
    ));
    return data;
  }

  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(
      String id) async {
    Future<Either<Failure, List<ProductModel>>> data = safeApi.call(
        apiCall: _appServiceClient.geCategoryProducts(
            consumerKey: AppUrls.consumerKeyValue,
            consumerSecret: AppUrls.consumerSecretValue,
            keyPermissions: AppUrls.keyPermissionsValue,
            categoriesID: id));
    return data;
  }

  Future<Either<Failure, ProductModel>> geSingleProducts(String id) async {
    Future<Either<Failure, ProductModel>> data = safeApi.call(
        apiCall: _appServiceClient.geSingleProducts(
      id: id,
      consumerKey: AppUrls.consumerKeyValue,
      consumerSecret: AppUrls.consumerSecretValue,
    ));
    return data;
  }
}