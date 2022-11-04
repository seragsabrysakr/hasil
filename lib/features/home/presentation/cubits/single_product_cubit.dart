import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class SingleProductsCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final AppPreferences _preferences;
  SingleProductsCubit(this._repository, this._preferences)
      : super(ContentState());
  static SingleProductsCubit get(BuildContext context) =>
      context.read<SingleProductsCubit>();
  ProductModel? products;
  void getProduct(String id) {
    emit(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository.geSingleProducts(id).then((value) => value.fold(
          (failure) {
            emit(ErrorState(
                StateRendererType.fullScreenErrorState, failure.message));
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
