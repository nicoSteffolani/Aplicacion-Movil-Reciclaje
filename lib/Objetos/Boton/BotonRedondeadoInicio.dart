import 'package:flutter/material.dart';


class BotonCircular extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const BotonCircular({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Devulve las dimenciones de la pantalla en los ejes X e Y
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: ClipRRect( // Crea un rectangulo con bordes circulares dentro del cual puede ir el boton
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom( // Constructor del boton
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          ),
          onPressed: press,
          child: Text( // Muestra el texto de la variable text dentro del boton
            text,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
