import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/app.dart';
import 'package:hassel/app_routes.dart';
import 'package:hassel/core/app_business_logic/state_renderer/request_builder.dart';
import 'package:hassel/core/app_business_logic/state_renderer/state_renderer_impl.dart';
import 'package:hassel/core/dependency_injection/dependency_injection.dart';
import 'package:hassel/features/auth/presentation/cubit/register_cubit.dart';
import 'package:hassel/data/model/customer.dart';
import 'package:hassel/shared/app_utils/app_assets.dart';
import 'package:hassel/shared/app_utils/app_colors.dart';
import 'package:hassel/shared/app_utils/app_navigator.dart';
import 'package:hassel/shared/app_utils/app_sized_box.dart';
import 'package:hassel/shared/app_utils/app_text_style.dart';
import 'package:hassel/shared/app_utils/app_validation.dart';
import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:hassel/shared/app_widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  RegisterCubit? _cubit;
  void navigateTo(String route, {Object? arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    systemOverLay();

    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: RequestBuilder<RegisterCubit>(
              listener: (context, cubit) {
                if (cubit.state is SuccessState) {
                  navigateTo(Routes.logInRoute);
                }
              },
              contentBuilder: (context, cubit) {
                _cubit = cubit;
                return buildScreenContent();
              },
              retry: (context, cubit) {})
          // buildScreenContent(),
          ),
    );
  }

  SingleChildScrollView buildScreenContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildImageHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildWelcomeText(),
                  buildLogInForm(),
                  buildLogInButton(),
                  buildFooter()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildLogInButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _cubit!.createUser(CustomerModel(
                  email: emailController.text,
                  password: passController.text,
                  firstName: phoneController.text,
                  lastName: ''));

              //     .register(
              //   userName: phoneController.text,
              //   password: passController.text,
              //   email: emailController.text,
              // );
            }
          },
          fontSize: 13.sp,
          radius: .5,
          buttonColor: AppColors.primaryColor,
          titleColor: Colors.white,
          fontWeight: FontWeight.w500,
          title: App.tr.createAccount,
          height: 6.h,
          width: 80.w,
        ),
        AppSizedBox.s1,
      ],
    );
  }

  Column buildLogInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSizedBox.s1,
        CustomTextField(
            action: TextInputAction.next,
            type: TextInputType.emailAddress,
            controller: emailController,
            hint: App.tr.email,
            validator: (String? value) {
              return Validations.emailValidation(value);
            }),
        CustomTextField(
            action: TextInputAction.next,
            type: TextInputType.name,
            controller: phoneController,
            hint: App.tr.name,
            validator: (String? value) {
              return Validations.userNameValidation(value);
            }),
        CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: passController,
            // hi: 10,
            obscure: showPassword,
            visiblpass: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            suffix: showPassword ? Icons.visibility : Icons.visibility_off,
            hint: App.tr.password,
            validator: (String? value) {
              return Validations.passwordValidation(value);
            }),
        AppSizedBox.s1,
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AppNavigator.navigateAndFinish(
                    context: context, screen: Routes.logInRoute);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
              ),
              child: Text(
                App.tr.logIn,
                style: AppTextStyle.getSemiBoldStyle(
                    color: AppColors.headerColor, fontSize: 11.sp),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              App.tr.iHaveAccount,
              style: AppTextStyle.getMediumStyle(
                  color: AppColors.subTitle, fontSize: 11.sp),
            ),
          ],
        ),
        AppSizedBox.s2,
      ],
    );
  }

  Widget buildImageHeader() {
    return Stack(
      children: [
        Container(
          height: 46.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              image: const DecorationImage(
                  image: AssetImage(AppAssets.register),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter)),
        ),
        Positioned(
            // top: 0,
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.25),
                Colors.black.withOpacity(.1)
              ],
            ),
          ),
          height: 12.h,
        )),
        Positioned(
          top: 7.h,
          left: 34.w,
          right: 34.w,
          child: Text(
            App.tr.newRegister,
            style: AppTextStyle.getMediumStyle(
                color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppSizedBox.s2,
        Text(
          App.tr.createAccount,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.headerColor, fontSize: 18.sp),
        ),
        AppSizedBox.s1,
        Text(
          App.tr.createFastAccount,
          style: AppTextStyle.getMediumStyle(
              color: AppColors.subTitle, fontSize: 11.sp),
        ),
        AppSizedBox.s1,
      ],
    );
  }

  void systemOverLay() {
    return SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));
  }
}
