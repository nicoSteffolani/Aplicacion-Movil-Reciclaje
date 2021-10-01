import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

class CooperativesPage extends StatefulWidget {
  const CooperativesPage({Key? key}) : super(key: key);

  @override
  _CooperativesPageState createState() => _CooperativesPageState();
}

class _CooperativesPageState extends State<CooperativesPage> {
  String formatTime(String time){
    DateTime dateTime = DateTime.parse('2021-01-01 $time');
    return '${dateTime.hour}:${dateTime.minute}0';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooperativas"),
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
        child: FutureBuilder<List<CenterModel>>(
          future: g.models.updateCenters(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CenterModel> list = snapshot.data!;
              return Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (_,__) => Divider(height: 1),
                  itemBuilder: (_,index) {
                    return ListTile(
                      title: Text(
                          'Cooperativa ${list[index].name}'
                      ),
                      subtitle: Text("Horario de atencion: de ${(list[index].initTime == null)? '00:00': formatTime(list[index].initTime)} hasta ${(list[index].stopTime == null)? '23:59': formatTime(list[index].stopTime)}"),
                      onTap: (){
                        Navigator.of(context).pushNamed("/cooperative",arguments: {"center": list[index].toDatabaseJson()});
                      },

                    );
                  },
                  itemCount: list.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

