import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TheamProvider with ChangeNotifier {
  static String themeStatus = "THEME_STATUS";

  bool _darkTheme = false;

  bool get getIsDarkTheme => _darkTheme;

  TheamProvider() {
    getTheme();
  }

  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = themeValue;
    await prefs.setBool(themeStatus, themeValue); // Save theme preference
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(themeStatus) ?? false;
    notifyListeners();
    return _darkTheme;
  }
}
