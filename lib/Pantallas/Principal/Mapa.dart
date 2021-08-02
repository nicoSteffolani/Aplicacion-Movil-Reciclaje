import 'package:ecoinclution_proyect/Objetos/Mapa/MapPoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class Mapa extends StatelessWidget {
  Widget _buildMap(BuildContext context) {
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
          markers: [ //Vector de puntos mostrados en el mapa
            MapPoint(-31.415, -64.183, Icons.add_location).newPoint(context), //Inicializo un nuevo MapPoint y automaticamente llamo a
          ],                                                               // la funcion newPoint para que me retorne un tipo marker
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMap(context),
    );
  }


}


