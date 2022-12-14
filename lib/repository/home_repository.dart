import 'package:dartz/dartz.dart';
import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/core/data/network/save_api.dart';
import 'package:hassel/data/model/cart_order_model.dart';
import 'package:hassel/data/model/cart_request_model.dart';
import 'package:hassel/data/model/cart_response_model.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/order_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/data/storage/home/home_api_services.dart';
import 'package:hassel/data/storage/home/home_local_data_source.dart';
import 'package:hassel/data/storage/woo_serivecs.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRepository {
  final HomeServiceClient _appServiceClient;
  final SafeApi safeApi;
  final HomeLocal _homeLocal;
  final AppPreferences appPreferences;
  final WooServices _wooServices;

  HomeRepository(
    this._appServiceClient,
    this.safeApi,
    this.appPreferences,
    this._homeLocal,
    this._wooServices,
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

  Future<Either<Failure, List<OrderModel>>> getOrders(String customer) async {
    Future<Either<Failure, List<OrderModel>>> data = safeApi.call(
        apiCall: _appServiceClient.getOrders(
            consumerKey: AppUrls.consumerKeyValue,
            consumerSecret: AppUrls.consumerSecretValue,
            customer: customer));
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

  Future<Either<Failure, OrderModel>> getSingleOrder(String id) async {
    Future<Either<Failure, OrderModel>> data = safeApi.call(
        apiCall: _appServiceClient.getSingleOrder(
      id: id,
      consumerKey: AppUrls.consumerKeyValue,
      consumerSecret: AppUrls.consumerSecretValue,
    ));
    return data;
  }

  Future<Either<Failure, CartOrderModel>> addItemToCart(
      {required CartProducts body}) async {
    Future<Either<Failure, CartOrderModel>> data =
        safeApi.call(apiCall: _wooServices.addtoCart(body));
    return data;
  }

  Future<Either<Failure, CartResponseModel>> getCartItems() async {
    Future<Either<Failure, CartResponseModel>> data =
        safeApi.call(apiCall: _wooServices.getCartItems());
    return data;
  }
}
