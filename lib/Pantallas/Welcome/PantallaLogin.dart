import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Objetos/Login/RecomendText.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/PantallaBase.dart';
import 'package:ecoinclution_proyect/Pantallas/Welcome/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorFondo,
      body: LoginPage()
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key key,
    this.name,
    this.contra,
  }) : super(key: key);

  final TextEditingController name;
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
              child: Text("Inicio Sesion",
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
            ),
            InputText(
              text: "Contraseña",
              contra: true,
              controler: contra,
            ),
            BotonCircular(
              color: kColorPrimario,
              textColor: kBlanco,
              text: "Ingresar",
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PaginaPrincipal();
                    }
                  ),
                );
              },
            ),
            LogText(
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Registrate();
                    },
                  ),
                );
              },
              login: true,
            ),
            LoginGF(),
          ],
        ),
      ),
    );
  }
}




