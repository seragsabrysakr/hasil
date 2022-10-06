import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:injectable/injectable.dart';


import '../../domain/usecase/user_usecase.dart';

@injectable
class UserCubit extends Cubit<FlowState> {
  final UseCase _useCase;

  UserCubit(this._useCase) : super(ContentState());

  static UserCubit get(BuildContext context) => context.read<UserCubit>();

  void login() {
    emit(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    // emit(ContentState());

    _useCase.execute(Void).then((value) => value.fold((failure) {
          // print("errorMessage: ${failure.message}");
          emit(ErrorState(StateRendererType.toastErrorState, failure.message));
        }, (data) {
      // print(data.toString());
          emit(SuccessState(
            data: data,
            message: '',
            stateRendererType: StateRendererType.toastSuccess,
          ));
          // print(data);
        }));
  }
}
