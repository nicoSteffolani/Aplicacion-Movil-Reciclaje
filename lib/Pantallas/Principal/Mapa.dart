import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';



class Mapa extends StatelessWidget {

  @override
  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-34.12, -63.38),
        zoom: 8.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(-34.12, -63.38),
              builder: (ctx) =>
              Container(
                child: IconButton(icon: Icon(
                  Icons.add_location,
                  size: 35,
                  ),
                  onPressed: () {
                    print("seleccionado");
                    return showAlertDialog(context);
                  },
                ),
              ),
            ),
          ],
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

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Punto de acopio"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


