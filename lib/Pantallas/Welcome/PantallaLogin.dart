import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Boton/BotonRedondeadoInicio.dart';
import 'package:ecoinclution_proyect/Objetos/Login/OpcionLoginGF.dart';
import 'package:ecoinclution_proyect/Objetos/Login/RecomendText.dart';
import 'package:ecoinclution_proyect/Objetos/text/textImput.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/PantallaBase.dart';
import 'package:ecoinclution_proyect/Pantallas/Welcome/Register.dart';
import 'package:ecoinclution_proyect/Global.dart';
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
class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage> {

  final name = TextEditingController();
  final contra = TextEditingController();
  String _errorText = "";
  @override
  Widget build(BuildContext context) { // Constructor de la ventana Login
    return Container(  // Se coloca dentro de un container para poder centrarla
      alignment: Alignment.center,
        child: SingleChildScrollView( // Al colocarla dentro se evita problemas con la vista en caso de que se gire la pantalla
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container( // Titutlo de la ventana
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Text("Inicio Sesion",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: kColorAma,
              ),
              ),
            ),
            InputText( // Espacion para introducir el nombre de usuario
              text: "Nombre de Usuario",
              contra: false,
              controler: name,
              icono: Icons.person,
            ),
            InputText( // Espacion para introducir la contraseña
              text: "Contraseña",
              contra: true,
              controler: contra,
            ),
            Text(
              _errorText,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
            ),
            BotonCircular( // Boton para validar los datos
              color: kColorPrimario,
              textColor: kBlanco,
              text: "Ingresar",
              press: () async { // Todo validar los datos que se ingresan
                await userRepository.authenticate(username: name.text, password: contra.text).then((value) {
                  print("ok");
                  userRepository.persistToken(user:value);
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context)  {

                        return PaginaPrincipal();
                      }
                  ),);
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

            LogText( // Texto que ofrece crear una cuenta en caso de no tener
              press: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context){
                      return Registrate(); // Redireciona a la pagina de register
                    },
                  ),
                );
              },
              login: true,
            ),
            LoginGF(context: context,), // Genre el divisor y los dos botones que te perimeten Iniciar secion con google o Facebook
          ],
        ),
      ),
    );
  }
}




