import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/repository/auth_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserInfoCubit extends Cubit<FlowState> {
  final AuthRepository _repository;
  final AppPreferences _preferences;

  UserInfoCubit(this._repository, this._preferences) : super(ContentState());

  static UserInfoCubit get(BuildContext context) =>
      context.read<UserInfoCubit>();
  UserModel? user;
  void getUserInfo() {
    emit(LoadingState(stateRendererType: StateRendererType.contentState));

    _repository.getUserInfo().then((value) => value.fold((failure) {
          print("errorMessage: ${failure.message}");
          emit(ErrorState(StateRendererType.toastErrorState, ''));
        }, (data) {
          print(data.toString());
          user = data.first;
          _preferences.userDataModel = user;

          emit(SuccessState(
            StateRendererType.contentState,
            message: '',
          ));
          // print(data);
        }));
  }
}
