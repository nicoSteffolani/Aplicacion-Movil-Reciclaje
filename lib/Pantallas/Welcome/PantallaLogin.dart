import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
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
    Size size = MediaQuery.of(context).size;
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
              icono: Icons.vpn_key_sharp,
            ),
            BotonCircular(
              color: kColorPrimario,
              textColor: kBlanco,
              text: "Ingresar",
              press: () {},
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30),
              child :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No tine Cuenta aún ? ",
                    style: TextStyle(
                    fontSize: 15,
                  ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        color: kColorAma,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LoginGF(),
          ],
        ),
      ),
    );
  }
}



