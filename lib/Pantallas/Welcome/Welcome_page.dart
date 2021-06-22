import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Pantallas/Welcome/PantallaLogin.dart';
import 'package:ecoinclution_proyect/Pantallas/Welcome/Register.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: kColorFondo,
    body: Ventana(size: size),
    );
  }
}

class Ventana extends StatelessWidget {
  const Ventana({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(image: AssetImage("assets/images/logo-eco.png"),
            width: size.width * 0.8 , height: size.height * 0.5,
            ),
            BotonCircular(
              text: "Login",
              color: kColorSecundario,
              textColor: kBlanco,
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Login();
                    },
                  ),
                );
              },
            ),
            BotonCircular(
              text: "Registrarse",
              color: kColorVerde,
              textColor: kBlanco,
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Registrate();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

