import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryProductsCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final AppPreferences _preferences;
  CategoryProductsCubit(this._repository, this._preferences)
      : super(LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState));
  static CategoryProductsCubit get(BuildContext context) =>
      context.read<CategoryProductsCubit>();
  List<ProductModel> products = [];
  void getCategoryProducts(String id) {
    emit(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    _repository.getCategoryProducts(id).then((value) => value.fold(
          (failure) {
            emit(
                ErrorState(StateRendererType.toastErrorState, failure.message));
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
