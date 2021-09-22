import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments ;
    print("route: ${settings.name}");


    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/map':
        return MaterialPageRoute(builder: (_) => HomePage(pageIndex: 0,));
      case '/cooperatives':
        return MaterialPageRoute(builder: (_) => HomePage(pageIndex: 1,));
      case '/deposits':
        g.models.updateAmounts();
        return MaterialPageRoute(builder: (_) => HomePage(pageIndex: 2,));
      case '/cooperative':
        Map<String, dynamic> map = args as Map<String, dynamic>;
        CenterModel centerModel =CenterModel.fromJson(map['center']);
        return MaterialPageRoute(builder: (_) => CooperativePage(center: centerModel));

      case '/edit_deposit':

        Map<String, dynamic> map = args as Map<String, dynamic>;
        print(map);
        Deposit? deposit;
        if (map['deposit'] != null) {
          deposit = Deposit.fromJson(map['deposit']);
        }
        bool create = map['create'];
        return MaterialPageRoute(builder: (_) => EditDepositPage(create: create,deposit: deposit,));
      case '':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      default:
        return MaterialPageRoute(builder: (_) => WelcomePage());
    }
  }
}
