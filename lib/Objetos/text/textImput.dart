import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool contra;
  final TextEditingController controler;
  final IconData icono;

  const InputText({
    Key key,
    this.text,
    this.contra,
    this.controler,
    this.icono,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if (contra){
      return esContra(size);
    }else{
      return esTexto(size);
    }
  }

  Container esContra(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: TextField(
        obscureText: contra,
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(icono),
          suffixIcon: Icon(Icons.visibility),
        ),
      ),
    );
  }

  Container esTexto(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: TextField(
        obscureText: contra,
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(icono),
        ),
      ),
    );
  }
}
