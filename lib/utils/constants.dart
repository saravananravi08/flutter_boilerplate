import 'package:flutter/material.dart';

class AppTheme {
  static int primaryColorCode = (0xff0000ff);
  static Color primaryColor = Color(primaryColorCode);
  static Color commonTextColor = Colors.black87;
  static String appName = '';
}

class AppConstants {
  static String graphqlEndpoint = '';
  static String apiEndpoint = '';
}

Map<int, Color> appPrimaryColor = {
  50: AppTheme.primaryColor.withOpacity(0.05),
  100: AppTheme.primaryColor.withOpacity(0.1),
  200: AppTheme.primaryColor.withOpacity(0.2),
  300: AppTheme.primaryColor.withOpacity(0.3),
  400: AppTheme.primaryColor.withOpacity(0.4),
  500: AppTheme.primaryColor.withOpacity(0.5),
  600: AppTheme.primaryColor.withOpacity(0.6),
  700: AppTheme.primaryColor.withOpacity(0.7),
  800: AppTheme.primaryColor.withOpacity(0.8),
  900: AppTheme.primaryColor.withOpacity(0.9),
};
