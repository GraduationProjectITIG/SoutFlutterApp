import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../base_bloc.dart';
import '../theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LANGUAGES { AR, EN }

class AppBloc implements BaseBloc {
  final String locale;

  AppBloc({this.locale = 'ar'}) {
    if (this.locale == "en") {
      setLanguage(LANGUAGES.EN);
    }
  }

  static final AppState initialState = AppState(
    const Locale('en'),
    themeDataLight,
  );
  final BehaviorSubject<AppState> _appController =
      BehaviorSubject<AppState>.seeded(initialState);

  Stream<AppState> get stream => _appController.stream;

  LANGUAGES get f => _appController.value.locale == const Locale('EN')
      ? LANGUAGES.EN
      : LANGUAGES.AR;

  void setLanguage(LANGUAGES languages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", languages == LANGUAGES.EN ? "en" : "ar");
    _appController.add(
      AppState(
        languages == LANGUAGES.EN ? const Locale('EN') : const Locale('ar'),
        _appController.value.themeData,
      ),
    );
  }

  void toggleLanguage() {
    _appController.add(
      AppState(
        _appController.value.locale == const Locale('EN')
            ? const Locale('ar')
            : const Locale('EN'),
        _appController.value.themeData,
      ),
    );
  }

  void setThemeData(ThemeData themeData) => _appController.add(
        AppState(
          _appController.value.locale,
          themeData,
        ),
      );

  bool isDarkMood() => _appController.value.themeData == themeDataDark;

  String get themeName => _appController.value.themeData == themeDataLight
      ? 'Dark Mode 🌑'
      : 'Light Mode ☀️';

  void toggleTheme() {
    _appController.add(
      AppState(
          _appController.value.locale,
          (_appController.value.themeData == themeDataLight)
              ? themeDataDark
              : themeDataLight),
    );
  }

  @override
  void dispose() {
    _appController.drain();
    // _appController.close();
  }
}

class AppState {
  AppState(this.locale, this.themeData);

  final Locale locale;
  final ThemeData themeData;
}
