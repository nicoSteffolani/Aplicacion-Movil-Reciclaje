
import 'package:flutter/material.dart';

class DeleteDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Cuidado",style: Theme.of(context).textTheme.bodyText2,),
      content: Text("Estas seguro de que quieres eliminar este deposito?",style: Theme.of(context).textTheme.bodyText2,),
      actions: <Widget>[
        OutlinedButton( // Diseña el boton
          child: Text(
            "Si",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        OutlinedButton( // Diseña el boton
          child: Text(
            "No",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}