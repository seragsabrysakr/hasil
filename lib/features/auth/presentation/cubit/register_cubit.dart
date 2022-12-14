import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/customer.dart';
import 'package:hassel/data/model/user_model.dart';
import 'package:hassel/repository/auth_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<FlowState> {
  final AuthRepository _repository;
  final AppPreferences _preferences;

  RegisterCubit(this._repository, this._preferences) : super(ContentState());
  static RegisterCubit get(BuildContext context) =>
      context.read<RegisterCubit>();
  UserModel? user;
  createUser(CustomerModel model) {
    emit(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    _repository.createUser(model).then((value) => value.fold((failure) {
          print("errorMessage: ${failure.message}");
          emit(ErrorState(StateRendererType.toastErrorState, failure.message));
        }, (data) {
          print(data.toString());
          user = data;
          emit(SuccessState(
            StateRendererType.toastSuccess,
            message: 'تم أنشاء الحساب بنجاح',
          ));
          // print(data);
        }));
  }
}
