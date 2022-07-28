import 'package:flutter/material.dart';

class AppColors {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static const String apiKey = "91f20fef6924822ab6748495265321b5";
  static const String getReport = "/api/meteo/";
  static String primaryCol = '#EE82EE';
  static String whiteCol = '#FFFFFF';
  static String blackCol = '#000000';
  static String greyCol = '#808080';
  static String weatherICons = '#8E79C4';
}

class AppStyle {
  static TextStyle headingStyle = const TextStyle(
    fontFamily: 'Lato',
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
}

class RessourcesPath {
  static String sunnyLottie = 'assets/lotties/sunny.json';
  static String sunCycle = 'assets/lotties/sun_cycle.json';
}
