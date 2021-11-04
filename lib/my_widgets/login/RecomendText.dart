import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LogText extends StatelessWidget {
  final Function press;
  final bool login;
  const LogText({
    required this.press,
    required this.login,
  });

    @override
  Widget build(BuildContext context) {AppLocalizations? t = AppLocalizations.of(context);
    return Container( // Esta dentro de un conteiner para que se pueda centrar
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30),
      child :Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? t!.dontHave : t!.have , // Dependiendo de la vairable login que se define cuando se crea un LogText
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          GestureDetector( // Le otorga al texto la habilidad de detectar cuado se hace click sobre el
            onTap: () {press();},
            child: Text(
              " ${login ? t.register : t.login}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}