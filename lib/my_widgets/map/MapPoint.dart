import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class MapCenterPoint extends StatelessWidget { //Clase que contiene el punto de tipo marker

  final double latitud;
  final double longitud;
  final Icon icono;
  final CenterModel center;
  final ModelsManager mm;

  const MapCenterPoint(
      this.latitud,
      this.longitud,
      this.icono,
      this.center, this.mm
      );


  showAlertDialog(BuildContext context) { //Se crea la ventana de alerta que se muestra al tocar el icono
    AppLocalizations? t = AppLocalizations.of(context);
    Widget closeButton = OutlinedButton( // Diseña el boton
      child: Text(
        t!.closeButton,
      ),
      onPressed: () {
        Navigator.of(context)
            .pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );
    Widget viewButton = OutlinedButton.icon( // Diseña el boton
      label: Text(
        t.infoButton,
      ),
      icon: Icon(Icons.info),
      onPressed: () {
        mm.selectCenter(center);
        Navigator.of(context)
            .pushNamed("/cooperative"); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },

    );
    Widget addButton = OutlinedButton.icon( // Diseña el boton

      icon: const Icon(Icons.add),
      onPressed: () {

        Deposit deposit = Deposit(place: center, recyclingType: center.recyclingTypes.first);
        mm.selectDeposit(deposit);
        Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
      },
      label: Text(t.addDepositButton),

    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta
      title: Text("${t.cooperative}: ${center.name}"),
      content:Text(" ${t.seeMoreText}\n\n   ${t.makeDepositText}"),
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
          IconButton( // Crea un icono en el mapa con la habilidad de ser selecionado
            icon: icono,
            onPressed: () {
              return showAlertDialog(context); // se ejecuta al presionar el icono
            },
          ),
    );
  }

  Marker newPoint(BuildContext context) { //Crea un punto nuevo con los parametros que se pasan en el contructor de MapPoint
    return _point(context);
  }

  @override
  Widget build(BuildContext context) { //Constructor de MapPoint
    return new MapCenterPoint(longitud, latitud, icono,center,mm);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CenterModel>('center', center));
  }
}
class MapPoint extends StatelessWidget { //Clase que contiene el punto de tipo marker

  final double latitud;
  final double longitud;
  final Icon icono;
  final ModelsManager mm;
  final Point point;

  const MapPoint(
      this.latitud,
      this.longitud,
      this.icono,
      this.point, this.mm
      );


  showAlertDialog(BuildContext context) { //Se crea la ventana de alerta que se muestra al tocar el icono
    AppLocalizations? t = AppLocalizations.of(context);
    Widget closeButton = OutlinedButton( // Diseña el boton
      child: Text(
        t!.closeButton,
      ),
      onPressed: () {
        Navigator.of(context)
            .pop(); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },
    );
    Widget viewButton = OutlinedButton.icon( // Diseña el boton
      icon: const Icon(Icons.info_outline),
      label: Text(t.infoButton),
      onPressed: () {
        CenterModel? center;
        mm.centers.forEach((element){
          if (element.id == point.center){
            center = element;
          }
        });
        mm.selectCenter(center!);
        Navigator.of(context)
            .pushNamed("/cooperative"); // Al ejecutarse elimina la ultima parte de la ruta de la pagina haciendo que vuelva a la pagina anterior
      },

    );
    Widget addButton = OutlinedButton.icon( // Diseña el boton
      label: Text(t.addDepositButton),
      icon: const Icon(Icons.add),
      onPressed: () {
        Deposit deposit = Deposit(place: point, recyclingType: point.recyclingTypes.first);
        mm.selectDeposit(deposit);
        Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
      },


    );


    AlertDialog alert = AlertDialog( // diseña la ventana de alerta

      title: Text(point.name,),
      content:Text(" ${t.seeMoreText}\n\n   ${t.makeDepositText}"),
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
        IconButton( // Crea un icono en el mapa con la habilidad de ser selecionado
          icon: icono,
          onPressed: () {
            return showAlertDialog(context); // se ejecuta al presionar el icono
          },
        ),
    );
  }

  Marker newPoint(BuildContext context) { //Crea un punto nuevo con los parametros que se pasan en el contructor de MapPoint
    return _point(context);
  }

  @override
  Widget build(BuildContext context) { //Constructor de MapPoint
    return new MapPoint(longitud, latitud, icono,point,mm);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Point>('point', point));
  }

}