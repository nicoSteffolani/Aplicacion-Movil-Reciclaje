import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeModeHandler.of(context)?.themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
        actions: [
        ],
      ),

      body: Center(
        child: FutureBuilder<User>(
            future: g.userRepository.getUser(id: 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListTile(
                      title: Text("${snapshot.data!.username}"),
                      subtitle: Text("Federico Sironi"),
                      leading: Icon(Icons.person),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Cuenta"),
                      subtitle: Text("Seguridad, Cambiar contraseña, Cerrar cuenta, Eliminar Cuenta"), // TODO hacer manejo de cuenta
                      leading: Icon(Icons.vpn_key),
                      onTap: (){
                        Navigator.of(context).pushNamed("/account");
                      },
                    ),
                    ListTile(
                      title: Text("Tema"),
                      subtitle: Text("Actual: ${themeMode.toString().replaceFirst(RegExp(r'ThemeMode.'), "")}, Toca para cambiar"), // TODO hacer manejo de cuenta
                      leading: Icon(Icons.brightness_4_rounded),
                      onTap: () {
                        _selectThemeMode(context).then((theme){
                          setState(() {
                          });
                        });
                      },
                    ),
                    ListTile(
                      title: Text("Notificaciones"),
                      subtitle: Text("Tonos de mensajes, Cuando mostrar notificacion"),// TODO hacer manejo de notificaciones
                      leading: Icon(Icons.notifications_rounded),
                    ),
                    ListTile(
                      title: Text("Ayuda"),
                      subtitle: Text("Centro de ayuda, Reportar bugs"),// TODO hacer manejo de notificaciones
                      leading: Icon(Icons.help_outline),
                    ),
                    Expanded(
                        child:Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(bottom:32),
                            child: Text("from "),
                          ),
                        )
                    ),
                  ],
                );
              }else if (snapshot.hasError){

              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }

  Future<dynamic> _selectThemeMode(BuildContext context) async {
    Future<dynamic> newThemeMode = showThemePickerDialog(context: context);
    return newThemeMode;
  }
}