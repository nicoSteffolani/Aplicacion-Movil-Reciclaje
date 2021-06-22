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
              child: Text("Regístrate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: kColorAma,
                ),
              ),
            ),
            InputText(
              text: "Nombre de Usuario",
              contra: false,
              controler: name,
              icono: Icons.person,
            ), //nombre
            InputText(
              text: "Mail",
              contra: false,
              controler: mail,
              icono: Icons.mail_outline_sharp,
            ), //mail
            InputText(
              text: "Contraseña",
              contra: true,
              controler: contra,
            ), //contra
            BotonCircular(
              color: kColorPrimario,
              textColor: kBlanco,
              text: "Aceptar",
              press: () {},
            ),
            LogText(
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Login();
                    },
                  ),
                );
              },
              login: false,
            ),
            LoginGF(),
          ],
        ),
      ),
    );
  }

}