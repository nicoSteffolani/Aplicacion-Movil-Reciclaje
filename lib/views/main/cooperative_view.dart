import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:ecoinclution_proyect/models/point_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

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
    DateTime dateTime = DateTime.parse('2021-01-01 $time');
    return '${dateTime.hour}:${dateTime.minute}0';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooperativa: ${center.name}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
        ],
      ),

      body: Center(


        child: FutureBuilder<List<Point>>(
          future: g.models.updatePoints(),
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

