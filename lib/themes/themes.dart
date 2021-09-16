import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

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
      primaryColor: Colors.green,
      backgroundColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(

        style:  TextButton.styleFrom(
          primary: Colors.green,
          shadowColor: Colors.black,
          elevation: 10,
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          textStyle:  TextStyle(

            color: Colors.white,
          ),
        ),
      ),

      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),

        bodyText1: TextStyle(
          color: Colors.black,
        ),
        bodyText2: TextStyle(color: Colors.green),
        button: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(
          color: Colors.black,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        selectedIconTheme:IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.black
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
      ),

    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textButtonTheme: TextButtonThemeData(
        style:  TextButton.styleFrom(
          primary: Colors.black,
          shadowColor: Colors.black,
          elevation: 10,
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          textStyle:  TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline2: TextStyle(
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),

        bodyText1: TextStyle(
          color: Colors.black,
        ),
        bodyText2: TextStyle(color: Colors.white),
        button: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,

        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        selectedIconTheme:IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        selectedLabelStyle: TextStyle(
            color: Colors.white
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ),

    );
  }
}