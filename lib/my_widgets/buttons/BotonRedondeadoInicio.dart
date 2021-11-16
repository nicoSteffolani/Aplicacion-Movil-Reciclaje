import 'package:flutter/material.dart';


class BotonCircular extends StatelessWidget {
  final String text;
  final Function press;
  const BotonCircular({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      child: ClipRRect( // Crea un rectangulo con bordes circulares dentro del cual puede ir el boton
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shadowColor: Colors.black,
            elevation: 10,
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          ),
          onPressed: () {press();},
          child: Text( // Muestra el texto de la variable text dentro del boton
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
