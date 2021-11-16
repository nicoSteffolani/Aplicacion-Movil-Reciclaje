import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart' as g;
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme extends ChangeNotifier{
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFFC65F00),
      accentColor: Color(0xFF67BC00),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 35,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        //selectedItemColor: Color(0xFFFFFFFF),
        //unselectedItemColor: Color(0xFFFFFFFF).withOpacity(0.38),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          primary: Color(0xFFC65F00),
          primaryVariant:Color(0xFFC65F00),
          secondary:Color(0xFF67BC00),
          secondaryVariant: Color(0xFF67BC00),
          surface: Colors.white
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFFC65F00),
      accentColor: Color(0xFF67BC00),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 35,
        ),
        selectedItemColor: Color(0xFFC65F00),
        showUnselectedLabels: true,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: Color(0xFFC65F00),
        primaryVariant: Color(0xFFC65F00),
        secondary: Color(0xFF67BC00),
        secondaryVariant: Color(0xFF67BC00),
        surface:  Color(0xFF2B2B2B),
        onSurface: Color(0xFFFFFFFF),
      ),
    );
  }
}
class MyManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    String theme = "ThemeMode.system";
    bool hasToken = await g.userRepository.hasToken(id: 0);
    if (hasToken){
      User user = await g.userRepository.getUser(id: 0);
      print("theme mode: ${user.theme}");
      print("paso por aca");
      theme = user.theme;
    }

    return theme;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    bool result = false;
    bool hasToken = await g.userRepository.hasToken(id: 0);
    if (hasToken){
      User user = await g.userRepository.getUser(id: 0);
      user.theme = value;
      await g.userRepository.updateUser(user: user);
      result = true;
      print(result);
    }
    return result;
  }
}
