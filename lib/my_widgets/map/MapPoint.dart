import 'package:ecoinclution_proyect/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ecoinclution_proyect/global.dart' as g;


class MapCenterPoint extends StatelessWidget { //Clase que contiene el punto de tipo marker

  final double latitud;
  final double longitud;
  final IconData icono;
  final CenterModel center;

  const MapCenterPoint(
      this.latitud,
      this.longitud,
      this.icono,
      this.center
      );


  showAlertDialog(BuildContext context) { //Se crea la ventana de alerta que se muestra al tocar el icono
    Widget closeButton = OutlinedButton( // Diseña el boton
      child: Text(
        "Cerrar",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        Navigator.of(context)
            .pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );
    Widget viewButton = OutlinedButton( // Diseña el boton
      child: Text(
        "Abrir",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed("/cooperative",arguments:{"center": center.toDatabaseJson()}); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },

    );
    Widget addButton = IconButton( // Diseña el boton

      icon: const Icon(Icons.add),
      onPressed: () {
        Deposit deposit = Deposit(center: center.id);
        Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true,"deposit":deposit.toDatabaseJson()});
      },
      tooltip: "Añadir deposito",

    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta
      backgroundColor: Theme.of(context).cardColor,
      title: Text(center.nombre,
        style: Theme.of(context).textTheme.bodyText1,),
      actions: [
        addButton,
        viewButton,
        closeButton,
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
    return new MapCenterPoint(longitud, latitud, icono,center);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CenterModel>('center', center));
  }
//  AVISO IMPORTANTE: cuando se hace una llamada a esta funcion dentro de Mapa.dart, debe ir acompañada siempre del metodo newPoint
//  dado que este segundo retorna un tipo Marker el cual es  necesario para poder agregarlo a la lista de markers dentro de Mapa.dart
}
class MapPoint extends StatelessWidget { //Clase que contiene el punto de tipo marker

  final double latitud;
  final double longitud;
  final IconData icono;
  final Point point;

  const MapPoint(
      this.latitud,
      this.longitud,
      this.icono,
      this.point
      );


  showAlertDialog(BuildContext context) { //Se crea la ventana de alerta que se muestra al tocar el icono
    Widget closeButton = OutlinedButton( // Diseña el boton
      child: Text(
        "Cerrar",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        Navigator.of(context)
            .pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );
    Widget viewButton = OutlinedButton( // Diseña el boton
      child: Text(
        "Abrir",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        CenterModel? center;
        g.models.centers.forEach((element){
          if (element.id == point.center){
            center = element;
          }
        });
        Navigator.of(context)
            .pushNamed("/cooperative",arguments:{"center": center!.toDatabaseJson()}); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },

    );
    Widget addButton = IconButton( // Diseña el boton

      icon: const Icon(Icons.add),
      onPressed: () {
        Deposit deposit = Deposit(center: point.center,point: point.id);
        Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true,"deposit":deposit.toDatabaseJson()});
      },
      tooltip: "Añadir deposito",

    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta
      backgroundColor: Theme.of(context).cardColor,
      title: Text(point.name,
        style: Theme.of(context).textTheme.bodyText1,),
      actions: [
        addButton,
        viewButton,
        closeButton,
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
    return new MapPoint(longitud, latitud, icono,point);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Point>('point', point));
  }
//  AVISO IMPORTANTE: cuando se hace una llamada a esta funcion dentro de Mapa.dart, debe ir acompañada siempre del metodo newPoint
//  dado que este segundo retorna un tipo Marker el cual es  necesario para poder agregarlo a la lista de markers dentro de Mapa.dart
}