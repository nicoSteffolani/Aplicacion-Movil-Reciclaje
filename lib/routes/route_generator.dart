import 'package:ecoinclution_proyect/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      default:
        return MaterialPageRoute(builder: (_) => WelcomePage());
    }
  }
}
