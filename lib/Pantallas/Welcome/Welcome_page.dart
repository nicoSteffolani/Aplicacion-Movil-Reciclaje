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
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(image: // Muestra una imagen
              AssetImage("assets/images/logo-eco.png"
            ),
            width: size.width * 0.8 , // con estas proporciones
            height: size.height * 0.5,
            ),
            BotonCircular( // Boton de Login
              text: "Login",
              color: kColorSecundario,
              textColor: kBlanco,
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Login(); // Redirecciona a la ventan login
                    },
                  ),
                );
              },
            ),
            BotonCircular( // Boton de registrarse
              text: "Registrarse",
              color: kColorVerde,
              textColor: kBlanco,
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Registrate(); // Redirecciona a la ventan Resgistrarse
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

