import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/cart_order_model.dart';
import 'package:hassel/data/model/cart_request_model.dart';
import 'package:hassel/data/model/cart_response_model.dart';
import 'package:hassel/data/model/customer.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

import '../../shared/app_utils/app_urls.dart';

@injectable
class WooServices {
  Future<UserModel> createUser(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ":" + Config.secret),
    );
    var response = await Dio().post(Config.url + Config.customerURL,
        data: model.toJson(),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: "application/json"
        }));
    UserModel user = UserModel.fromJson(response.data);
    return user;
  }

  Future<CartOrderModel?> addtoCart(CartProducts model) async {
    CartOrderModel? responseModel;
    String url = Config.addToCart +
        "&consumer_key=${Config.key}&consumer_secret=${Config.secret}";
    print(url);
    try {
      final token =
          getIt<AppPreferences>().getData(AppPreferences.userToken, '');
      var response = await Dio().post(
        url,
        data: model.toJson(),
        options: Options(
          headers: {
            if (token != '') "authorization": token,
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        responseModel = CartOrderModel.fromJson(response.data);
        print(response.toString());
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        print(e.response);
      } else {
        print(e.response);
      }
    }

    return responseModel;
  }

  Future<CartResponseModel?> getCartItems() async {
    CartResponseModel? responseModel;

    try {
      UserModel? user = getIt<AppPreferences>().userDataModel!;

      if (user != null) {
        // int userId = loginResponseModel.data.id;

        String url = Config.url +
            Config.addToCart +
            "&consumer_key=${Config.key}&consumer_secret=${Config.secret}";
        print(url);
        var response = await Dio().get(
          url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        );

        if (response.statusCode == 200) {
          responseModel = CartResponseModel.fromJson(response.data);
        }
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return responseModel;
  }
}
