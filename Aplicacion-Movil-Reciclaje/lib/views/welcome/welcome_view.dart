import 'package:ecoinclution_proyect/my_widgets/buttons/BotonRedondeadoInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(t!.welcomeTitle),
      ),
      body: Ventana(size: size),
    );
  }
}

class Ventana extends StatelessWidget {
  const Ventana({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    return Container(

      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: // Muestra una imagen
                  AssetImage("assets/images/logo_comprimido.png"),
              width: size.width * 0.8, // con estas proporciones
              height: size.height * 0.5,
            ),
            BotonCircular(
              // Boton de Login
              text: t!.login,
              press: () {
                Navigator.of(context).pushNamed("/login");
              },
            ),
            BotonCircular(
              // Boton de registrarse
              text: t.register,
              press: () {
                Navigator.of(context).pushNamed("/register");
              },
            ),
          ],
        ),
      ),
    );
  }
}
