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
        primaryColor: kColorPrimario,
        // dividerTheme: DividerThemeData(
        //   color: kColorAma,
        //   thickness: 3,
        //   indent: 15,
        //   endIndent: 15,
        //),
        //scaffoldBackgroundColor: kColorSecundario,
        //backgroundColor: Colors.lightBlueAccent,
      ),
      home: WelcomeScreen(),
    );
  }
}


