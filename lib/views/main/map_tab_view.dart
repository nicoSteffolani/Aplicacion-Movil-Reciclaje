import 'package:ecoinclution_proyect/Objetos/Mapa/MapPoint.dart';
import 'package:ecoinclution_proyect/api_connection/center_api.dart';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CenterModel>>(
        future: fetchCenters(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            List<Marker> listMarker = [];
            snapshot.data!.forEach((row) {
              Marker marker = MapPoint(double.parse(row.lat), double.parse(row.long), Icons.house,row).newPoint(context);
              listMarker.add(marker);
            });
            return FlutterMap(

              options: MapOptions( // Indica la posicion y zoom con el que inicia el mapa
                center: LatLng(-31.415, -64.183),
                zoom: 11.0,
              ),

              layers: [
                TileLayerOptions( // Se crea la vista del mapa sobre la cual se puede trabajar
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']
                ),

                MarkerLayerOptions(
                  markers: listMarker

                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('error en el mapa');
          }
          // By default, show a loading spinner.
          return Center(
                  child: CircularProgressIndicator()
              );

        },
      ),
    );
  }




}

