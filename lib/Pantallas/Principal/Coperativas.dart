import 'package:ecoinclution_proyect/Pantallas/Principal/Models.dart';
import 'package:flutter/material.dart';

class FetchedData extends StatefulWidget {
  const FetchedData({Key? key}) : super(key: key);

  @override
  _FetchedDataState createState() => _FetchedDataState();
}

class _FetchedDataState extends State<FetchedData> {
  late Future<List<Centro>> listCentro;

  @override
  void initState() {
    super.initState();
    listCentro = fetchCentros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(


        child: FutureBuilder<List<Centro>>(
          future: listCentro,
          builder: (context, snapshot) {

            if (snapshot.hasData) {

              List<Widget> listWidget = [];
              snapshot.data!.forEach((row) {
                listWidget.add(
                  ListTile(
                    leading: Icon(
                      Icons.add_comment,
                      color: Colors.green,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    title: Text(
                      row.nombre,
                    ),
                    subtitle: Text(
                        "lat: " + row.lat.toString() + " long: " + row.long.toString()
                    ),

                  ),
                );

              });
              return Scrollbar(

                child: ListView(
                  restorationId: 'data_table_list_view',
                  padding: const EdgeInsets.all(10),
                  children: listWidget,
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

