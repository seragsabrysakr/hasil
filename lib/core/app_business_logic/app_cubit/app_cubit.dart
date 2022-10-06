import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassel/shared/app_utils/app_prefs.dart';
import 'package:hassel/shared/app_utils/app_strings.dart';
import 'package:hassel/shared/app_utils/app_theme.dart';
import 'package:injectable/injectable.dart';
part 'app_state.dart';
@injectable
class AppCubit extends Cubit<AppState> {
  final AppPreferences _preferences;
  AppCubit(this._preferences) : super(AppInitial()) {
    locale = Locale(_preferences.getLanguage());
    theme = _preferences.getTheme();
  }
  static AppCubit get(context) => BlocProvider.of(context);

  late Locale locale;
  late ThemeData? theme;

  bool get isArSelected => _preferences.getLanguage() == AppStrings.arLanguage;
  bool get isDarkMode =>
      _preferences.getTheme() == appThemeData[AppTheme.darkAppTheme];

  void setLang(String lang) {
    locale = Locale(lang);
    _preferences.setLanguage(lang);
    emit(ChangeLanguage());
  }

  void changeLang() {
    if (isArSelected) {
      setLang(AppStrings.enLanguage);
    } else {
      setLang(AppStrings.arLanguage);
    }
  }

  void setTheme(bool isDark) {
    if (isDark) {
      theme = appThemeData[AppTheme.darkAppTheme];
    } else {
      theme = appThemeData[AppTheme.lightAppTheme];
    }
    _preferences.setTheme(isDark);
    emit(ChangeTheme());
  }

  void changeTheme() {
    if (isDarkMode) {
      setTheme(false);
    } else {
      setTheme(true);
    }
  }
}
