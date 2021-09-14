import 'package:ecoinclution_proyect/Pantallas/Welcome/Welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Constants.dart';
// import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/PantallaBase.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;
import 'package:google_sign_in/google_sign_in.dart';

// final user = LoginGF.user;


void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  final GoogleSignInAccount? user = g.user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depositos Ecoinclution',
      theme: ThemeData(
        primaryColor: kColorPrimario, //todas la constantes estan definidas con una k al principio
      ),
      home: FutureBuilder<Widget>(
        future: login(g.user,context),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return snapshot.data!;
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator()
              )
          );
        },
      )
    );
  }

  Future<Widget> login(GoogleSignInAccount? user,context) async {
    for (int i = 0; i < 20; i++) {
      await g.userRepository.deleteToken(id: i);

    }

    Widget widget = WelcomeScreen();
    if (user != null) { // redirecciona a la ventana de bienvenida
      widget =  PaginaPrincipal();
    }else{

      await g.userRepository.hasToken().then((value) {
        print(value);
        if (value){
          widget = PaginaPrincipal();
        }
      });



    }
    return widget;
  }
}