import 'package:ecoinclution_proyect/routes/route_generator.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:ecoinclution_proyect/views/main/tabs_view.dart';
import 'package:ecoinclution_proyect/views/views.dart';
import 'package:ecoinclution_proyect/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;




void main() async {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.init();
    currentTheme.addListener(() {
      setState(() {});
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depositos Ecoinclution',
      theme: CustomTheme.lightTheme,
      highContrastTheme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
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
  }


}