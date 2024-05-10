import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';

abstract class ThemeManger {
  static ThemeData getAppTheme() {
    return ThemeData(
        scaffoldBackgroundColor: ColorManger.black,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: ColorManger.black,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManger.white,
                fontSize: 21),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManger.black,
            )));
  }
}
