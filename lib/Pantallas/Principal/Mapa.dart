import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';



class Mapa extends StatelessWidget {

  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      options: MapOptions( // Indica la posicion y zoom con el que inicia el mapa
        center: LatLng(-34.12, -63.38),
        zoom: 8.0,
      ),
      layers: [
        TileLayerOptions( // Se crea la vista del mapa sobre la cual se puede trabajar
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions( // Todo llevar el constructor de los puntos del mapa a un arichivo aparte
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(-34.12, -63.38),
              builder: (ctx) =>
              Container(
                child: IconButton(icon: Icon( // Crea un icono en el mapa con la habilidad de ser selecionado
                  Icons.add_location,
                  size: 35,
                  ),
                  onPressed: () {
                    print("seleccionado");
                    return showAlertDialog(context); // se ejecuta al presionar el icono
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


    Widget cancelButton = TextButton( // Diseña el boton
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta
      title: Text("Punto de acopio"),
      actions: [
        cancelButton,
      ], //
    );


    showDialog( // constructor de la ventana de alerta
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


