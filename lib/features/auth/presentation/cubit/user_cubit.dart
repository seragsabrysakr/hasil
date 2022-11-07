import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/login_model.dart';
import 'package:hassel/repository/auth_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<FlowState> {
  final AuthRepository _repository;
  final AppPreferences _preferences;

  LoginCubit(this._repository, this._preferences) : super(ContentState());

  static LoginCubit get(BuildContext context) => context.read<LoginCubit>();
  LoginResponseModel? user;
  void login({required String userName, required String password}) {
    emit(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    _repository
        .login(userName: userName, password: password)
        .then((value) => value.fold((failure) {
              print("errorMessage: ${failure.message}");
              emit(ErrorState(StateRendererType.toastErrorState,
                  'خطأ في أسم المستخدم او كلمة المرور'));
            }, (data) {
              print(data.toString());
              user = data;
              var token = user!.token!;
              print(token);
              _preferences.token = user!.token!;

              emit(SuccessState(
                StateRendererType.toastSuccess,
                message: 'تم تسجيل الدخول بنجاح',
              ));
              // print(data);
            }));
  }
}
