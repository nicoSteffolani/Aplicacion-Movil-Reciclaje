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
            login ? "No tines cuenta?  " : "Ya tienes una cuenta?  ", // Dependiendo de la vairable login que se define cuando se crea un LogText
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          GestureDetector( // Le otorga al texto la habilidad de detectar cuado se hace click sobre el
            onTap: () {press();},
            child: Text(
              login ? "Registrate" : "Iniciar sesión",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}