import 'package:ecoinclution_proyect/api_connection/point_api.dart';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:ecoinclution_proyect/models/point_model.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

class CooperativePage extends StatefulWidget {
  final CenterModel center;
  CooperativePage({required this.center});

  @override
  _CooperativePageState createState() => _CooperativePageState(center: center);
}

class _CooperativePageState extends State<CooperativePage> {
  final CenterModel center;
  _CooperativePageState({required this.center});

  String formatTime(String time){
    DateTime dateTime = DateTime.parse('2021-01-01 ${time}');
    return '${dateTime.hour}:${dateTime.minute}0';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooperativa: ${center.nombre}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () async {
              await g.userRepository.getUser(id: 0).then((value) async {
                var user = value;
                currentTheme.toggleThemeBool(!(user.theme));
                await g.userRepository.updateUser(user: User(id: user.id, username: user.username,token: user.token,theme: !(user.theme)));
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),

      body: Center(


        child: FutureBuilder<List<Point>>(
          future: fetchPoints(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              List<Point> list = [];
              snapshot.data!.forEach((row){
                if (row.center == center.id){
                  list.add(row);
                }
              });
              return Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (_,__) => Divider(height: 1,color: Colors.green),
                  itemBuilder: (_,index) {
                    return ListTile(
                      title: Text(
                          'Punto: ${list[index].name}'
                      ),
                      subtitle: Text("Recicla: ${list[index].tipoDeReciclado}"),
                      onTap: (){

                      },

                    );
                  },
                  itemCount: list.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

