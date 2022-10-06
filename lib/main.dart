import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/app_business_logic/app_cubit/app_cubit.dart';
import 'core/app_business_logic/bloc_observer.dart';
import 'shared/app_utils/app_prefs.dart';
import 'core/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(
    //   DevicePreview(
    // enabled: false,
    // builder: (context) =>
    MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) => getIt<AppCubit>()),
      ],
      child: App(preferences: getIt<AppPreferences>()),
    ), // Wrap your app
    // )
  );
}
