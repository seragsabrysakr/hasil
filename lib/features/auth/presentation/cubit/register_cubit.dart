import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/data/model/login_model.dart';
import 'package:hassel/repository/auth_repository.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:injectable/injectable.dart';
import 'package:monahawk_woocommerce/woocommerce.dart';

@injectable
class RegisterCubit extends Cubit<FlowState> {
  final AuthRepository _repository;
  final AppPreferences _preferences;

  RegisterCubit(this._repository, this._preferences) : super(ContentState());

  static RegisterCubit get(BuildContext context) =>
      context.read<RegisterCubit>();
  LoginResponseModel? user;
  void register({
    required String userName,
    required String password,
    required String email,
  }) async {
    emit(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    WooCommerce wooCommerce = WooCommerce(
      baseUrl: AppUrls.baseUrl,
      consumerKey: AppUrls.consumerKeyValue,
      consumerSecret: AppUrls.consumerSecretValue,
      isDebug: true,
    );
    WooCustomer user =
        WooCustomer(username: userName, password: password, email: email);
    bool result = await wooCommerce.createCustomer(user).whenComplete(() {
      emit(SuccessState(
        StateRendererType.toastSuccess,
        message: 'تم أنشاء الحساب بنجاح',
      ));
    }).catchError((e) {
      emit(ErrorState(StateRendererType.toastErrorState,
          'هناك بحساب بنفس الايميل أو نفس أسم المستخدم'));
    });
  }
}
