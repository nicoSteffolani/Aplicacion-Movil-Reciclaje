import 'package:ecoinclution_proyect/models/models_manager.dart' as g;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuenta"),
        actions: [
        ],
      ),

      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text("Seguridad"),
              leading: Icon(Icons.security),
              onTap: (){
              },
            ),
            ListTile(
              title: Text("Cerrar cuenta"),
              leading: Icon(Icons.logout),
              onTap: () async {
                final result = await showDialog(context: context,builder: (_) => Logout());
                if (result){
                  g.userRepository.deleteToken(id: 0).then((_) {
                    Fluttertoast.showToast(
                      msg: "Cuenta cerrada exitosamente",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                  },onError: (error){
                    Fluttertoast.showToast(
                      msg: "Cuenta cerrada exitosamente",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                  });
                }
              },
            ),
            ListTile(
              title: Text("Eliminar mi cuenta"),
              leading: Icon(Icons.delete),
              onTap: (){
              },
            ),
          ],
        ),
      ),
    );
  }
}
class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("Cerrar cuenta"),
      content: Text("Estas seguro de que quieres cerrar la cuenta?",),
      actions: <Widget>[
        OutlinedButton( // Diseña el boton
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        OutlinedButton( // Diseña el boton
          child: Text("Aceptar"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}