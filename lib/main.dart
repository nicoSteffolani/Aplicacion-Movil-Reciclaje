import 'package:ecoinclution_proyect/Pantallas/Welcome/Welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Constants.dart';
// import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/PantallaBase.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;
import 'package:google_sign_in/google_sign_in.dart';

// final user = LoginGF.user;


void main() {
  runApp(MyApp(user: g.user));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final GoogleSignInAccount? user;

  const MyApp ({
    required this.user ,});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depositos Ecoinclution',
      theme: ThemeData(
        primaryColor: kColorPrimario, //todas la constantes estan definidas con una k al principio
      ),
      home: login(g.user,context),
    );
  }

  Widget login(GoogleSignInAccount? user,context) {
    print(user);
    if (user != null) { // redirecciona a la ventana de bienvenida
      return PaginaPrincipal();
    }else{
      g.userRepository.hasToken().then((value) {
        if (value){
            return PaginaPrincipal();
        }
      });


    }
    //return WelcomeScreen();
  }
}