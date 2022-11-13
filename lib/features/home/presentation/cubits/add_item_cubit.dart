import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/data/model/cart_order_model.dart';
import 'package:hassel/data/model/cart_request_model.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddItemToCartCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final AppPreferences _preferences;
  AddItemToCartCubit(this._repository, this._preferences)
      : super(ContentState());
  static AddItemToCartCubit get(BuildContext context) =>
      context.read<AddItemToCartCubit>();
  List<CartOrderModel> _cartItems = [];
  List<CartOrderModel> get cartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();
  double? get totalAmount => _cartItems.isNotEmpty
      ? _cartItems
          .map((e) => e.lineSubtotal)
          .reduce((value, element) => value ?? 0 + element!.toDouble())
      : 0;
  void addItemToCart(
    CartProducts product,
    String count,
  ) async {
    CartRequestModel requestModel = CartRequestModel();
    // requestModel.products = List<CartProducts>() ;
    requestModel.products = <CartProducts>[];

    UserModel? user = getIt<AppPreferences>().userDataModel!;

    var isProductExist = requestModel.products?.firstWhere(
      (prd) =>
          prd.productId == product.productId &&
          prd.variationId == product.variationId,
      orElse: () => CartProducts(),
    );

    if (isProductExist != null) {
      requestModel.products?.remove(isProductExist);
    }

    requestModel.products?.add(product);
    emit(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository
        .addItemToCart(body: requestModel.products!.first)
        .then((value) => value.fold(
              (failure) {
                emit(ErrorState(
                    StateRendererType.popupErrorState, failure.message));
                print("errorMessage: ${failure.message}");
              },
              (data) {
                print(data.toString());
                model = data;
                data.quantity = int.parse(count);
                _cartItems.add(data);
                emit(SuccessState(StateRendererType.popupSuccess,
                    message: 'تم أضافه العنصر لسلة الشراء'));
              },
            ));
  }

  CartOrderModel? model;
}
