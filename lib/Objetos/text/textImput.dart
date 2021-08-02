import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool contra;
  final TextEditingController controler;
  final IconData icono;

   InputText({
    Key? key,
     required this.text,
     required this.contra,
     required this.controler,
     this.icono = Icons.plus_one,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size; // Devuelve un valor con el tamaño de los ejes X e Y de la pantalla

    if (contra){ // Pregunta si la variable contra es true cuando se crea el InputText
      return esContra(size);
    }else{
      return esTexto(size);
    }
  }

  // validator: (val) => val.length < 6 ? 'Password too short.' : null,
  // onSaved: (val) => _password = val,


  Container esContra(Size size) { // En caso de que es = true se ejecuta este constructor
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: TextField(
        obscureText: true, // Esta es la principal diferencia: mustra las letras como puntos en la pantalla
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(Icons.vpn_key_sharp), // La otra diferencia es el icono
            // suffixIcon: Icon(Icons.visibility),
        ),
      ),
    );
  }

  Container esTexto(Size size) { // En caso de que contra es false se ejecuta este constructor
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(icono),
        ),
      ),
    );
  }
}
