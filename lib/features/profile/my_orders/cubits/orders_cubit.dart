import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/order_model.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final AppPreferences _preferences;
  OrdersCubit(this._repository, this._preferences)
      : super(LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState));
  static OrdersCubit get(BuildContext context) => context.read<OrdersCubit>();
  List<OrderModel> orders = [];

  void getAllProducts() {
    emit(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository.getOrders(_preferences.userDataModel!.id.toString()).then((value) => value.fold(
          (failure) {
            emit(ErrorState(
                StateRendererType.fullScreenErrorState, failure.message));
            print("errorMessage: ${failure.message}");
          },
          (data) {
            print(data.toString());
            orders = data;
            emit(ContentState());
          },
        ));
  }
}
