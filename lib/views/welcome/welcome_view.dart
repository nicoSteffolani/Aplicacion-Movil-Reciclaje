import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/my_widgets/buttons/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          ),
        ],
      ),
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
            Image(
              image: // Muestra una imagen
                  AssetImage("assets/images/logo-eco.png"),
              width: size.width * 0.8, // con estas proporciones
              height: size.height * 0.5,
            ),
            BotonCircular(
              // Boton de Login
              text: "Login",
              color: buttonColor,
              textColor: textColor,
              press: () {
                Navigator.of(context).pushNamed("/login");
              },
            ),
            BotonCircular(
              // Boton de registrarse
              text: "Registrarse",
              color: buttonColor,
              textColor: textColor,
              press: () {
                Navigator.of(context).pushNamed("/register");
              },
            ),
          ],
        ),
      ),
    );
  }
}
