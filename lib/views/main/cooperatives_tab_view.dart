import 'package:ecoinclution_proyect/api_connection/center_api.dart';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:flutter/material.dart';

class CooperativesPage extends StatefulWidget {
  const CooperativesPage({Key? key}) : super(key: key);

  @override
  _CooperativesPageState createState() => _CooperativesPageState();
}

class _CooperativesPageState extends State<CooperativesPage> {
  String formatTime(String time){
    DateTime dateTime = DateTime.parse('2021-01-01 ${time}');
    return '${dateTime.hour}:${dateTime.minute}0';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(


        child: FutureBuilder<List<CenterModel>>(
          future: fetchCenters(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              List list = [];
              snapshot.data!.forEach((row){
                if (row.verificado){
                  list.add(row);
                }
              });
              return Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (_,__) => Divider(height: 1,color: Colors.green),
                  itemBuilder: (_,index) {
                    return ListTile(
                      title: Text(
                        'Cooperativa ${list[index].nombre}'
                      ),
                      subtitle: Text("Horario de atencion: de ${(list[index].horarioInicio == null)? '00:00': formatTime(list[index].horarioInicio)} hasta ${(list[index].horarioFinal == null)? '23:59': formatTime(list[index].horarioFinal)}"),
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

