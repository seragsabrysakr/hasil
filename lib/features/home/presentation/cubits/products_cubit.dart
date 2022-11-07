import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/data/storage/home/home_local_data_source.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final HomeLocal _local;
  ProductsCubit(this._repository, this._local)
      : super(LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState));
  static ProductsCubit get(BuildContext context) =>
      context.read<ProductsCubit>();
  List<ProductModel> products = [];
  void getAllProducts() async {
    try {
      final response = await _local.getProducts();
      products = response;
      emit(ContentState());
    } catch (e) {
      emit(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      _repository.geAllProducts().then((value) => value.fold(
            (failure) {
              emit(ErrorState(
                  StateRendererType.toastErrorState, failure.message));
              print("errorMessage: ${failure.message}");
            },
            (data) {
              print(data.toString());
              products = data;
              _local.saveProductsToCache(data);
              emit(ContentState());
            },
          ));
    }
  }
}
