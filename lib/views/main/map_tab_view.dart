import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:ecoinclution_proyect/my_widgets/map/MapPoint.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:location/location.dart';


class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
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
      body: FutureBuilder<List<CenterModel>>(
        future: g.models.updateCenters(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            List<Marker> listMarker = [];
            snapshot.data!.forEach((row) {
              Marker marker = MapCenterPoint(double.parse(row.lat), double.parse(row.long), Icons.house,row).newPoint(context);
              listMarker.add(marker);
            });

            g.models.points.forEach((row) {
              Marker marker = MapPoint(double.parse(row.lat), double.parse(row.long), Icons.location_pin,row).newPoint(context);
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
            return Text('Error');
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


