import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:ecoinclution_proyect/my_widgets/map/MapPoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:ecoinclution_proyect/global.dart' as g;


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationData? _currentLocation;
  @override
  initState() {
    getLocation().then((location){
      if (location != null) {
        location.onLocationChanged.listen((LocationData currentLocation) {
          // Use current location
          if (this.mounted) {
            setState(() {
              _currentLocation = currentLocation;
            });
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
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
              Marker marker = MapCenterPoint(double.parse(row.lat), double.parse(row.lng), Icons.house,row).newPoint(context);
              listMarker.add(marker);
            });

            g.models.points.forEach((row) {
              Marker marker = MapPoint(double.parse(row.lat), double.parse(row.lng), Icons.location_pin,row).newPoint(context);
              listMarker.add(marker);
            });
            if (_currentLocation != null){
              listMarker.add(
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  builder: (ctx) =>
                    IconButton( // Crea un icono en el mapa con la habilidad de ser selecionado
                      icon: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          // false = user must tap button, true = tap outside dialog
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text('Tu ubicacion'),
                              content: Text('se actuliza sola.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cerrar'),
                                  onPressed: () {
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );// se ejecuta al presionar el icono
                      },
                    ),
                )
              );
            }
            return FlutterMap(

              options: MapOptions( // Indica la posicion y zoom con el que inicia el mapa
                center:(_currentLocation != null)? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!) : LatLng(-31.415, -64.183),
                zoom: 13.0,
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
            return Center(child:Text('Error'));
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

Future<Location?> getLocation() async {

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  _locationData = await location.getLocation();
  return location;
}