import 'package:ecoinclution_proyect/models/models_manager.dart' as g;
import 'package:ecoinclution_proyect/my_widgets/login/RecomendText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String _errorUsername = "";
  String _errorPassword = "";

  bool loading = false;
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
  }

  @override
  Widget build(BuildContext context) {
    mm = context.watch<ModelsManager>();
    loading = false;
    if(mm.modelsStatus == ModelsStatus.updating){
      loading = true;

    }

    AppLocalizations? t = AppLocalizations.of(context);
    // Constructor de la ventana Login
    return Scaffold(
      appBar: AppBar(
        title: Text(t!.login),

      ),
      body:Container(
        // Se coloca dentro de un container para poder centrarla

        child: SingleChildScrollView(
          // Al colocarla dentro se evita problemas con la vista en caso de que se gire la pantalla
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    t.login,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextFormField(
                    enabled: !loading,
                      validator:(val){
                        if(val == null || val == "" ) {
                          return t.required;
                        }
                        if (_errorUsername != ''){
                          return _errorUsername;
                        }
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: t.username,
                        hintText: t.username,
                        icon: Icon(Icons.person),
                      )
                  ),

                  TextFormField(
                      enabled: !loading,
                      validator:(val){
                        if(val == null || val == "" ) {
                          return t.required;
                        }
                        if (_errorPassword != ''){
                          return _errorPassword;
                        }
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: t.password,
                        hintText: t.password,
                        icon: Icon(Icons.vpn_key_sharp),
                      )
                  ),
                  Container(height:16),
                  ElevatedButton.icon(
                    icon: (loading)? CircularProgressIndicator(): Container(),
                    autofocus: true,
                      onPressed: (!loading)?() async {
                        setState(() {
                          _errorUsername = "";
                          _errorPassword = "";
                        });
                        if (_formKey.currentState!.validate()) {
                          mm.authenticateUser(username: usernameController.text,
                              password: passwordController.text)
                              .then((value) {
                            g.userRepository.persistToken(user: value);
                            mm.modelsStatus = ModelsStatus.started;
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

                          }, onError: (error) {
                            setState(() {
                              print(error);
                              _errorUsername = (error['non_field_errors'].toString() == "null")? "": error['non_field_errors'][0].toString();
                              _errorPassword = (error['non_field_errors'].toString() == "null")? "": error['non_field_errors'][0].toString();
                              _formKey.currentState!.validate();
                            });
                          });
                        }
                      }:null,
                      label: Text( // Muestra el texto de la variable text dentro del boton
                          t.login,
                      ),
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
          ),
        ),
      )
    );
  }
}
