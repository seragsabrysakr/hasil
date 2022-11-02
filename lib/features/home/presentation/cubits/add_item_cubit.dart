import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/cart_order_model.dart';
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
  CartOrderModel? model;
  void addItemToCart(String id, String quantity) {
    emit(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository.addItemToCart(id: id, quantity: quantity).then((value) =>
        value.fold(
          (failure) {
            emit(
                ErrorState(StateRendererType.popupErrorState, failure.message));
            print("errorMessage: ${failure.message}");
          },
          (data) {
            print(data.toString());
            model = data;
            emit(SuccessState(StateRendererType.popupSuccess,
                message: 'تم أضافه العنصر لسلة الشراء'));
          },
        ));
  }
}
