import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapPoint extends StatelessWidget { //Clase que contiene el punto de tipo marker

  final double latitud;
  final double longitud;
  final IconData icono;
  final CenterModel center;

  const MapPoint(
      this.latitud,
      this.longitud,
      this.icono,
      this.center
      );


  showAlertDialog(BuildContext context) { //Se crea la ventana de alerta que se muestra al tocar el icono
    Widget cancelButton = OutlinedButton( // Diseña el boton
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onPressed: () {
        Navigator.of(context)
            .pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta
      title: Text(center.nombre),
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


  Marker _point(BuildContext context) { //Este es el punto que se muestra en el mapa
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(latitud, longitud),
      builder: (ctx) =>
          Container(
            child: IconButton( // Crea un icono en el mapa con la habilidad de ser selecionado
              icon: Icon(
                icono,
                size: 35,
              ),
              onPressed: () {
                return showAlertDialog(context); // se ejecuta al presionar el icono
              },
            ),
          ),
    );
  }

  Marker newPoint(BuildContext context) { //Crea un punto nuevo con los parametros que se pasan en el contructor de MapPoint
    return _point(context);
  }

  @override
  Widget build(BuildContext context) { //Constructor de MapPoint
    return new MapPoint(longitud, latitud, icono,center);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CenterModel>('center', center));
  }
  //  AVISO IMPORTANTE: cuando se hace una llamada a esta funcion dentro de Mapa.dart, debe ir acompañada siempre del metodo newPoint
  //  dado que este segundo retorna un tipo Marker el cual es  necesario para poder agregarlo a la lista de markers dentro de Mapa.dart
}