import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool contra;
  final TextEditingController controler;
  final IconData icono;

   InputText({
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

  // validator: (val) => val.length < 6 ? 'Password too short.' : null,
  // onSaved: (val) => _password = val,


  Container esContra(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(Icons.vpn_key_sharp),
            // suffixIcon: Icon(Icons.visibility),
        ),
      ),
    );
  }

  Container esTexto(Size size) {
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
