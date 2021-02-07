import 'package:flutter/material.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/res/themes.dart';
import 'package:dh/utils/index.dart';

class ThemeProvider extends ChangeNotifier {
  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark",
    Themes.LIGHT: "Light",
    Themes.SYSTEM: "System"
  };

  void syncTheme() {
    String theme = SpUtil.getString(Constants.DARK_MODE);
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]) {
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    SpUtil.putString(Constants.DARK_MODE, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false}) {
    String theme = SpUtil.getString(Constants.DARK_MODE);
    switch (theme) {
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }
    return ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light);
  }
}
