import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Objetos/Login/RecomendText.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
import 'package:ecoinclution_proyect/Pantallas/Welcome/PantallaLogin.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Constants.dart';


class Registrate extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorFondo,
      body: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget{

  const RegisterPage({
    Key key,
    this.name,
    this.mail,
    this.contra,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController mail;
  final TextEditingController contra;

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Text( // Titulo de la pagina
                "Regístrate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: kColorAma,
                ),
              ),
            ),
            InputText( // Espacio para ingrasar el nombre de usuario
              text: "Nombre de Usuario",
              contra: false,
              controler: name,
              icono: Icons.person,
            ), //nombre
            InputText( // Espacio para ingrasar el mail
              text: "Mail",
              contra: false,
              controler: mail,
              icono: Icons.mail_outline_sharp,
            ), //mail
            InputText( // Espacio para ingrasar la contraseña
              text: "Contraseña",
              contra: true,
              controler: contra,
            ), //contra
            BotonCircular( // Boton para validar los datos
              color: kColorPrimario,
              textColor: kBlanco,
              text: "Aceptar",
              press: () {}, // Todo validar los datos que se ingrasan
            ),
            LogText(  // Texto que ofrece iniciar sesion en caso de ya tener cuenta
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Login(); // Redirecciona a la venatana de login
                    },
                  ),
                );
              },
              login: false,
            ),
            LoginGF(), // Genre el divisor y los dos botones que te perimeten registrarte con google o Facebook
          ],
        ),
      ),
    );
  }

}