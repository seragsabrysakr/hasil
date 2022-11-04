import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:injectable/injectable.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

@injectable
class ProductsCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final AppPreferences _preferences;
  ProductsCubit(this._repository, this._preferences)
      : super(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  static ProductsCubit get(BuildContext context) => context.read<ProductsCubit>();
  List<ProductModel> products = [];
  Future getProducts() async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: AppUrls.baseUrl,
        consumerKey: AppUrls.consumerKeyValue,
        consumerSecret: AppUrls.consumerSecretValue);

    // Get data using the "products" endpoint
    List<dynamic> allproducts = await wooCommerceAPI.getAsync("products");
    for (var i = 0; i < allproducts.length; i++) {
      products.add(ProductModel.fromJson(allproducts[i]));
    }

    if (products.isNotEmpty) {
      emit(ContentState());
    }
    

    return products;
  }

  void getAllProducts() {
    emit(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository.geAllProducts().then((value) => value.fold(
          (failure) {
            emit(ErrorState(StateRendererType.toastErrorState, failure.message));
            print("errorMessage: ${failure.message}");
          },
          (data) {
            print(data.toString());
            products = data;
            emit(ContentState());
          },
        ));
  }
}
