import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

CustomTheme currentTheme = CustomTheme();

class CustomTheme extends ChangeNotifier{
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme {
    return _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  void toggleThemeBool(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }
  void init(){
    g.userRepository.getUser(id: 0).then((value) {
      User user = value;
      _isDarkTheme = user.theme;
    },onError: (error) {
      _isDarkTheme = false;
    });
  }



  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color(0xFF4CAE50),
      accentColor: Color(0xFFFDFD72),
      brightness: Brightness.light,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,

      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF087E23),
      accentColor: Color(0xFFC7B801),
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}