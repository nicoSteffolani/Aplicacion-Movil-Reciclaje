import 'package:flutter/material.dart';


class BotonCircular extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const BotonCircular({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
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
          onPressed: () {press();},
          child: Text( // Muestra el texto de la variable text dentro del boton
            text,
            style: Theme.of(context).textTheme.button
          ),
        ),
      ),
    );
  }
}
