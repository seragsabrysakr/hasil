import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/storage/home/home_local_data_source.dart';
import 'package:hassel/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<FlowState> {
  final HomeRepository _repository;
  final HomeLocal _local;

  CategoriesCubit(this._repository, this._local)
      : super(LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState));
  static CategoriesCubit get(BuildContext context) =>
      context.read<CategoriesCubit>();
  List<CategoryModel> categories = [];
  void getCategories() async {
    try {
      final response = await _local.getCategories();
      categories = response;
      emit(ContentState());
    } catch (e) {
      emit(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      _repository.getCategories().then((value) => value.fold(
            (failure) {
              emit(ErrorState(
                  StateRendererType.toastErrorState, failure.message));
              print("errorMessage: ${failure.message}");
            },
            (data) {
              print(data.toString());

              categories = data;
              _local.saveCategoriesToCache(data);

              emit(ContentState());
            },
          ));
    }
  }
}
