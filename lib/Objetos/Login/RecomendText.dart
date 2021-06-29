import 'package:ecoinclution_proyect/Constants.dart';
import 'package:flutter/material.dart';


class LogText extends StatelessWidget {
  final Function press;
  final bool login;
  const LogText({
    Key key,
    this.press,
    this.login,
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30),
      child :Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "¿No tines cuenta?  " : "¿Ya tenes una cueta?  ",
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: press,
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