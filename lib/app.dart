import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:sizer/sizer.dart';

import '../app_routes.dart';
import 'core/app_business_logic/app_cubit/app_cubit.dart';
import 'shared/app_utils/app_colors.dart';

class App extends StatelessWidget {
  final AppPreferences preferences;
  static late BuildContext appContext;
  static late AppLocalizations tr;
  const App({Key? key, required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, state) {
          var cubit = context.read<AppCubit>();
          return MaterialApp(
            onGenerateTitle: (context) {
              appContext = context;
              tr = AppLocalizations.of(context)!;
              return tr.appName;
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: cubit.locale,
            theme: _themeData(context),
            initialRoute: Routes.homeRoute,
            debugShowCheckedModeBanner: false,
            // home: const IntroScreen(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      );
    });
  }

  ThemeData _themeData(BuildContext context) {
    var langCubit = AppCubit.get(context);
    return ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        canvasColor: Colors.white,
        // fontFamily:
        //     langCubit.isArSelected ? Resources.arabicFont : Resources.mainFont,
        scaffoldBackgroundColor: AppColors.backGround,
        appBarTheme: _appBarTheme());
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      toolbarHeight: 8.h,
      elevation: 0,
      titleSpacing: 0,
      color: Colors.white,
      iconTheme: IconThemeData(
        color: AppColors.headerColor,
      ),
    );
  }

  // String getInitialRoute() {
  //   final token = preferences.getData(AppPreferences.userToken, '');
  //   print(token);
  //   if (token != '') {
  //     return MainScreen.id;
  //   } else {
  //     return LoginScreen.id;
  //   }
  // }
}
