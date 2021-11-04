import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart' as g;
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme extends ChangeNotifier{
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color(0xFF4CAE50),
      accentColor: Color(0xFFFDFD72),
      brightness: Brightness.light,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 35,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFFFFFFF),
        unselectedItemColor: Color(0xFFFFFFFF).withOpacity(0.38),
        backgroundColor: Color(0xFF4CAE50),
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF087E23),
      accentColor: Color(0xFFC7B801),
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 35,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFFFFFFF),
        unselectedItemColor: Color(0xFFFFFFFF).withOpacity(0.38),
        backgroundColor: Color(0xFF087E23),
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
