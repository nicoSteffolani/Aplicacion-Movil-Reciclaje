import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

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
              appBar: AppBar(
                title: Text("Usuario"),
                actions: [

                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                    },
                  ),
                ],
              ),
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
                              backgroundColor: Theme.of(context).cardColor,
                              title: Text("Desea desloguearse"),
                              content: Text(
                                "Debera iniciar sesion de nuevo si prosigue.",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              actions: <Widget>[
                                OutlinedButton(
                                  child: Text(
                                    "Cancelar",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(
                                    "Aceptar",
                                    style: Theme.of(context).textTheme.button),
                                  onPressed: () async {
                                    await g.userRepository.deleteToken(id: 0).then((_) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                                    },onError: (error){
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                                    });

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
