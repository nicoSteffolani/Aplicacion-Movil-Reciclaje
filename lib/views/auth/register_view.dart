import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/RecomendText.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

import '../../Global.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  
  
  String _errorUsername = "";
  String _errorEmail = "";
  String _errorFirstName = "";
  String _errorLastName = "";
  String _errorPassword = "";
  String _errorPassword2 = "";


  @override
  Widget build(BuildContext context) {
    // Constructor de la ventana Login
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
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
                    "Resgistrarse",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                InputText(
                  // Espacio para ingrasar el nombre de usuario
                  text: "Nombre de Usuario",
                  typePassword: false,
                  textEditingController: usernameController,
                  iconData: Icons.person,
                ),
                Text(
                  _errorUsername,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                InputText(
                  // Espacio para ingrasar el mail
                  text: "Email",
                  typePassword: false,
                  textEditingController: emailController,
                  iconData: Icons.mail_outline_sharp,
                ),
                Text(
                  _errorEmail,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                InputText(
                  // Espacio para ingrasar la contraseña
                  text: "Nombre",
                  typePassword: false,
                  textEditingController: firstNameController,
                  iconData: Icons.perm_contact_cal,
                ),
                Text(
                  _errorFirstName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                InputText(
                  // Espacio para ingrasar la contraseña
                  text: "Apellido",
                  typePassword: false,
                  textEditingController: lastNameController,
                  iconData: Icons.perm_contact_cal,
                ),
                Text(
                  _errorLastName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                  _errorEmail,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                //mail
                InputText(
                  // Espacio para ingrasar la contraseña
                  text: "Contraseña",
                  typePassword: true,
                  textEditingController: passwordController,
                ),
                Text(
                  _errorPassword,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                InputText(
                  // Espacio para ingrasar la contraseña
                  text: "Comprobar contraseña",
                  typePassword: true,
                  textEditingController: password2Controller,
                ),
                Text(
                  _errorPassword2,
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
                  press: () {
                    g.userRepository.registerUser(username: usernameController.text, email: emailController.text, firstName: firstNameController.text, lastName: lastNameController.text, password: passwordController.text, password2: password2Controller.text).then((value) async {
                      print(value);
                      await userRepository
                          .authenticateUser(username: usernameController.text, password: passwordController.text)
                          .then((value) {
                        print("ok");
                        userRepository.persistToken(user: value);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

                      }, onError: (error) {
                        print(error);
                      });

                    },onError: (error){
                      print(error);
                      setState(() {
                        _errorUsername = (error['username'].toString() == "null")? "": error['username'].toString();
                        _errorEmail = (error['email'].toString() == "null")? "": error['email'].toString();
                        _errorFirstName = (error['first_name'].toString() == "null")? "": error['first_name'].toString();
                        _errorLastName = (error['last_name'].toString() == "null")? "": error['last_name'].toString();
                        _errorPassword = (error['password'].toString() == "null")? "": error['password'].toString();
                        _errorPassword2 = (error['password2'].toString() == "null")? "": error['password2'].toString();
                      });
                    });
                  },
                ),

                LogText(
                  // Texto que ofrece crear una cuenta en caso de no tener
                  press: () {
                    Navigator.of(context).popAndPushNamed("/login");
                  },
                  login: false,
                ),

              ],
            ),
          ),
        )
    );
  }
}
