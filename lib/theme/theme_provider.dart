import 'package:flutter/material.dart';

import 'package:thydelivery_mobileapp/theme/dark_mode.dart';
import 'package:thydelivery_mobileapp/theme/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData themeData = lightMode;

  //getters
  bool get isDarkMode => themeData == darkMode;

  void toggleTheme() {
    if (themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
    notifyListeners(); //notify the Ui to change whenever there is a change in a state
  }
}
