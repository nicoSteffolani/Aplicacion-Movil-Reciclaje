import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget{
  final List<Marker> listMarker;
  final void Function(MapPosition position, bool hasGesture) onChanged;
  final void Function(MapController mapController) onCreated;
  final MapController mapController;
  const MapWidget({Key? key, required this.listMarker, required this.onChanged, required this.onCreated, required this.mapController}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return FlutterMap(
      mapController: mapController,
      options: MapOptions( // Indica la posicion y zoom con el que inicia el mapa
          center: LatLng(-31.415, -64.183),
          zoom: 13.0,
          onPositionChanged: (mapPosition, hasGesture){
            onChanged(mapPosition, hasGesture);
          },
          onMapCreated: (mapController){
            onCreated(mapController);
          }

      ),
      layers: [
        TileLayerOptions( // Se crea la vista del mapa sobre la cual se puede trabajar
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
            rotate: true,
            markers: listMarker
        ),
      ],

    );
  }

}

