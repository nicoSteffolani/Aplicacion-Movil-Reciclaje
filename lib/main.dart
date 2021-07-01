import 'package:ecoinclution_proyect/Pantallas/Welcome/Welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Constants.dart';

//import 'dart:html';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depositos Ecoinclution',
      theme: ThemeData(
        primaryColor: kColorPrimario, //todas la constantes estan definidas con una k al principio
      ),
      home: WelcomeScreen(), // redirecciona a la ventana de bienvenida
    );
  }
}


