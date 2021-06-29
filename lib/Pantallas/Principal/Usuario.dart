import 'package:flutter/material.dart';

class PaginaUsuario extends StatelessWidget {
  const PaginaUsuario({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Usuario",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
