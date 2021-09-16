import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/RecomendText.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
import 'package:ecoinclution_proyect/Global.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final name = TextEditingController();
  final contra = TextEditingController();
  String _errorText = "";

  @override
  Widget build(BuildContext context) {
    // Constructor de la ventana Login
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          ),
        ],
      ),
      body:Container(
        // Se coloca dentro de un container para poder centrarla

        child: SingleChildScrollView(
          // Al colocarla dentro se evita problemas con la vista en caso de que se gire la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // Titutlo de la ventana
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  "Inicio de Sesion",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              InputText(
                // Espacion para introducir el nombre de usuario
                text: "Nombre de Usuario",
                typePassword: false,
                textEditingController: name,
                iconData: Icons.person,
              ),
              InputText(
                // Espacion para introducir la contraseña
                text: "Contraseña",
                typePassword: true,
                textEditingController: contra,
              ),
              Text(
                _errorText,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
              BotonCircular(
                // Boton para validar los datos
                color: buttonColor,
                textColor: textColor,
                text: "Ingresar",
                press: () async {
                  await userRepository
                      .authenticateUser(username: name.text, password: contra.text)
                      .then((value) {
                    print("ok");
                    userRepository.persistToken(user: value);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

                    setState(() {
                      _errorText = '';
                    });
                  }, onError: (error) {
                    print(error);
                    setState(() {
                      _errorText = "username or password incorrect";
                    });
                  });
                  print(_errorText);
                },
              ),

              LogText(
                // Texto que ofrece crear una cuenta en caso de no tener
                press: () {
                  Navigator.of(context).popAndPushNamed("/register");
                },
                login: true,
              ),

            ],
          ),
        ),
      )
    );
  }
}
