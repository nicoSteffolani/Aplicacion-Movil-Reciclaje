import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Objetos/Login/SignIn.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/PantallaBase.dart';
import 'package:flutter/material.dart';


class LoginGF extends StatelessWidget {

  final BuildContext context;

  const LoginGF ({
    Key? key,
    required this.context}) :
  super(key: key);

  Future signIn() async{
    final user = await GoogleSignInApi.login();
    if (user == null){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Falló la conexion con google')));
    }else{
      print(user.displayName);
      print(user.email);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PaginaPrincipal()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Divider(
          color: kColorVerde,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 40),
          width: size.width * 0.8,
          child: ClipRRect( // Crea un rectangulo con bordes circulares dentro del cual puede ir el boton
            borderRadius: BorderRadius.circular(29),
            child: TextButton( // el constructor del boton
              style: TextButton.styleFrom( // El decorador de los botones de tipo TextButton
                textStyle: TextStyle(
                  color: kBlanco,
                ),
                backgroundColor: kBlanco,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60), // Esto lo separa de los demas objetos
              ),
              onPressed: signIn,// Todo hacer inicio de sesion con google funcion
              child: Image(
                image: AssetImage("assets/images/ISconGoogle.png"),
                alignment: Alignment.center,
                height: 35,
              ),
            ),
          ),
        ),
        Container(
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: kBlanco,
                ),
                backgroundColor: kBlanco,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              ),
              onPressed: () async {
                await GoogleSignInApi.logout();
              }, // Todo hacer inicio de sesion con facebook
              child: Image(
                image: AssetImage("assets/images/ISconFacebook.png"),
                alignment: Alignment.center,
                height: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}