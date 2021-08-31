import 'package:flutter/material.dart';

import '../../Global.dart' as g;

class PaginaUsuario extends StatelessWidget {
  const PaginaUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(usuario())
    );


  }


  String usuario(){

    if (g.user != null) {
      return g.user!.displayName.toString();
    }else{
      return "Inicie Sesión";
    }
  }
}
