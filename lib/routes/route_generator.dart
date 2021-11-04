import 'package:ecoinclution_proyect/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments ;
    print("route: ${settings.name}");


    switch (settings.name) {
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/account':
        return MaterialPageRoute(builder: (_) => AccountPage());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/cooperative':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => CooperativePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end =  Offset(0.0, 0.0);
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case '/edit_deposit':
        Map<String, dynamic> map = args as Map<String, dynamic>;
        bool create = map['create'];
        return MaterialPageRoute(builder: (_) => EditDepositPage(create: create));
      case '':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      default:
        return MaterialPageRoute(builder: (_) => WelcomePage());
    }
  }
}
