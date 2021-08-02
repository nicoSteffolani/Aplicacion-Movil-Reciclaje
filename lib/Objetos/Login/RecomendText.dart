import 'package:ecoinclution_proyect/Constants.dart';
import 'package:flutter/material.dart';


class LogText extends StatelessWidget {
  final Function press;
  final bool login;
  const LogText({
    required this.press,
    required this.login,
  });

    @override
  Widget build(BuildContext context) {
    return Container( // Esta dentro de un conteiner para que se pueda centrar
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30),
      child :Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "¿No tines cuenta?  " : "¿Ya tenes una cueta?  ", // Dependiendo de la vairable login que se define cuando se crea un LogText
            style: TextStyle(                                         // va a devolver un valor o el otro si es true es el primero
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector( // Le otorga al texto la habilidad de detectar cuado se hace click sobre el
            onTap: () {press();},
            child: Text(
              login ? "Registrate" : "Iniciar sesión",
              style: TextStyle(
                color: kColorAma,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}