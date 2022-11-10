import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/features/auth/presentation/cubit/user_info_cubit.dart';
import 'package:hassel/features/home/presentation/cubits/add_item_cubit.dart';

import 'app.dart';
import 'core/app_business_logic/app_cubit/app_cubit.dart';
import 'core/app_business_logic/bloc_observer.dart';
import 'core/dependency_injection/dependency_injection.dart';
import 'shared/app_utils/app_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(
    //   DevicePreview(
    // enabled: false,
    // builder: (context) =>
    MultiBlocProvider(
      providers: [
        BlocProvider<AddItemToCartCubit>(create: (context) => getIt<AddItemToCartCubit>()),
        BlocProvider<UserInfoCubit>(create: (context) => getIt<UserInfoCubit>()),
        BlocProvider<AppCubit>(create: (context) => getIt<AppCubit>()),
      ],
      child: App(preferences: getIt<AppPreferences>()),
    ), // Wrap your app
    // )
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
