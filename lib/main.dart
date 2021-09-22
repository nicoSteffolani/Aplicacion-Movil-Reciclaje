import 'package:ecoinclution_proyect/routes/route_generator.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:ecoinclution_proyect/views/main/tabs_view.dart';
import 'package:ecoinclution_proyect/views/views.dart';
import 'package:ecoinclution_proyect/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:theme_mode_handler/theme_mode_handler.dart';




void main() async {
  runApp(MyApp());
  await g.userRepository.hasToken(id: 0).then((value) async {
    if (value){
      await g.models.updateAll();
    }
  });
}

class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: MyManager(),
      placeholderWidget: Center(
        child: CircularProgressIndicator()
      ),
      builder: (ThemeMode themeMode){
        return MaterialApp(
          title: 'Depositos Ecoinclution',
          theme: CustomTheme.lightTheme,
          highContrastTheme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: themeMode,
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
          home: FutureBuilder<bool>(
              future: g.userRepository.hasToken(id: 0),
              builder: (context,snapshot) {
                if (snapshot.hasData){
                  if (snapshot.data!){
                    return HomePage();
                  }else{
                    return WelcomePage();
                  }
                }
                return LoadingPage();
              }
          ),
        );
      },
    );
  }


}