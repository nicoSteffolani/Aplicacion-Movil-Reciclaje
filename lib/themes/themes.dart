import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme extends ChangeNotifier{
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
class MyManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    String theme = "ThemeMode.system";
    User user = await g.userRepository.getUser(id: 0);
    theme = user.theme;
    print("theme mode: $theme");
    final theeme = ThemeMode.values.firstWhere(
          (v) => v.toString() == theme,
      orElse: () => ThemeMode.system,
    );
    print("temaaaaaaaaaaaaaaaaaaaaaa $theeme");
    return theme;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    String theme = value;
    bool result = false;
    g.userRepository.getUser(id: 0).then((value) {
      User user = value;
      user.theme = theme;
      g.userRepository.updateUser(user: user).then((value) => result = true, onError: (error){
        result = false;
      });
    },onError: (error) {
      result = false;
    });
    return result;
  }
}
