import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:ecoinclution_proyect/my_widgets/login/RecomendText.dart';
import 'package:ecoinclution_proyect/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  UserRepository userRepository = UserRepository();
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
          title: Text(t!.register),
        ),
        body:SingleChildScrollView(
          // Al colocarla dentro se evita problemas con la vista en caso de que se gire la pantalla
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    t.register,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextFormField(
                    enabled: (!loading),
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
                      enabled: (!loading),
                      validator:(val){
                        if(val == null || val == "" ) {
                          return t.required;
                        }
                        if (_errorEmail != ''){
                          return _errorEmail;
                        }
                      },
                      controller: emailController,

                      decoration: InputDecoration(
                        labelText: t.email,
                        hintText: t.email,
                        icon: Icon(Icons.email),
                      )
                  ),
                  TextFormField(
                      enabled: (!loading),
                      validator:(val){
                        if (_errorFirstName != '') {
                          return _errorFirstName;
                        }

                      },
                      controller: firstNameController,

                      decoration: InputDecoration(
                        labelText: t.firstName,
                        hintText: t.firstName,
                        icon: Icon(Icons.person_pin_sharp),
                      )
                  ),
                  TextFormField(
                      enabled: (!loading),
                      validator:(val){
                        if (_errorLastName != '') {
                          return _errorLastName;
                        }
                      },
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: t.lastName,
                        hintText: t.lastName,
                        icon: Icon(Icons.person_pin_sharp),
                      )
                  ),
                  TextFormField(
                      enabled: (!loading),
                      validator:(val){
                        if(val == null || val == "" ) {
                          return t.required;
                        }
                        if (_errorPassword != '') {
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
                  TextFormField(
                      enabled: (!loading),
                      validator:(val){
                        if(val == null || val == "" ) {
                          return t.required;
                        }
                        if (_errorPassword2 != '') {
                          return _errorPassword2;
                        }
                      },
                      controller: password2Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: t.password2,
                        hintText: t.password2,
                        icon: Icon(Icons.vpn_key_sharp),
                      )
                  ),
                  Container(height:16),
                  ElevatedButton.icon(
                    icon: (loading)? CircularProgressIndicator(): Container(),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,

                    ),
                    autofocus: true,
                    onPressed: (!loading)?() {
                      setState(() {
                        _errorUsername = "";
                        _errorEmail = "";
                        _errorFirstName = "";
                        _errorLastName = "";
                        _errorPassword = "";
                        _errorPassword2 = "";
                      });
                      if (_formKey.currentState!.validate()) {

                        mm.registerUser(username: usernameController.text, email: emailController.text, firstName: firstNameController.text, lastName: lastNameController.text, password: passwordController.text, password2: password2Controller.text).then((value) async {

                          await mm
                              .authenticateUser(username: usernameController.text, password: passwordController.text)
                              .then((value) {
                            userRepository.persistToken(user: value);
                            mm.modelsStatus = ModelsStatus.started;
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

                          }, onError: (error) {
                            print(error);
                          });


                        },onError: (error){
                          print(error);
                          setState(() {
                            _errorUsername = (error['username'].toString() == "null")? "": error['username'][0].toString();
                            _errorEmail = (error['email'].toString() == "null")? "": error['email'][0].toString();
                            _errorFirstName = (error['first_name'].toString() == "null")? "": error['first_name'][0].toString();
                            _errorLastName = (error['last_name'].toString() == "null")? "": error['last_name'][0].toString();
                            _errorPassword = (error['password'].toString() == "null")? "": error['password'][0].toString();
                            _errorPassword2 = (error['password2'].toString() == "null")? "": error['password2'][0].toString();
                            _formKey.currentState!.validate();
                          });
                        });
                      }

                    }:null,
                    label: Text( // Muestra el texto de la variable text dentro del boton
                      t.register,
                    ),
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
          ),
        )
    );
  }
}
