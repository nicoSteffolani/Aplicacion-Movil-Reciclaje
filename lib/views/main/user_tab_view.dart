import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: g.userRepository.getUser(id: 0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body:Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      snapshot.data!.username,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    GestureDetector( // Le otorga al texto la habilidad de detectar cuado se hace click sobre el
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (buildcontext) {
                            return AlertDialog(
                              title: Text("Desea desloguearse"),
                              content: Text(
                                "Debera iniciar sesion de nuevo si prosigue.",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              actions: <Widget>[
                                OutlinedButton(
                                  child: Text(
                                    "Cancelar",
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(
                                    "Aceptar",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.red),
                                  ),
                                  onPressed: (){
                                    g.userRepository.deleteToken(id: 0);
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator()
              )
          );
        }

    );

  }
}