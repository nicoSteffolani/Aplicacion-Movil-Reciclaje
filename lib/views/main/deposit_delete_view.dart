
import 'package:flutter/material.dart';

class DeleteDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Cuidado",style: TextStyle(color: Theme.of(context).errorColor),),
      content: Text("Estas seguro de que quieres eliminar este deposito?",style: Theme.of(context).textTheme.bodyText2,),
      actions: <Widget>[
        OutlinedButton( // Diseña el boton
          child: Text("Aceptar",style: TextStyle(color: Theme.of(context).errorColor),),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        OutlinedButton( // Diseña el boton
          child: Text("Cerrar",),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}