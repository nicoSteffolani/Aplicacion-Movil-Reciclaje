import 'package:ecoinclution_proyect/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

import '../../main.dart';




class PaginaUsuario extends StatefulWidget {
  @override
  _PaginaUsuario createState() => _PaginaUsuario();
}

class _PaginaUsuario extends State<PaginaUsuario> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
          future: g.userRepository.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data!.username,
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton( // Diseña el boton
                          child: Text("Log-out"),
                          onPressed: () {
                            print("");
                          },
                        )
                      ]
                  )
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator()
                )
            );
          }

      ),
    );
  }
}
