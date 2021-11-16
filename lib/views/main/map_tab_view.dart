import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:ecoinclution_proyect/my_widgets/map/MapPoint.dart';
import 'package:ecoinclution_proyect/views/main/cooperatives_tab_view.dart';
import 'package:ecoinclution_proyect/views/main/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

enum LocationStatus{

  centred,
  updating,
  notCentred,
  headingNorth
}
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late ModelsManager mm;
  MapController mapController = MapController();
  LocationStatus locationStatus = LocationStatus.notCentred;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
  }
  @override
  Widget build(BuildContext context) {

    AppLocalizations? t = AppLocalizations.of(context);
    mm = context.watch<ModelsManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text(t!.mapTitle),
        actions: [

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
          (mm.modelsStatus == ModelsStatus.updating)?Center(child: CircularProgressIndicator()):
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              mm.updateAll();
            },
          ),
        ],
      ),
      body: loadMap()
    );
  }
  Widget loadMap(){
    AppLocalizations? t = AppLocalizations.of(context);
    List<Marker> listMarker = [];
    mm.centers.forEach((row) {
      Marker marker = MapCenterPoint(row.lat, row.lng, Icon(Icons.house,color:Colors.black,size: 35,),row,mm).newPoint(context);
      listMarker.add(marker);
    });

    mm.points.forEach((row) {
      Marker marker = MapPoint(row.lat, row.lng, Icon(Icons.location_pin,color:Colors.black,size: 35,),row,mm).newPoint(context);
      listMarker.add(marker);
    });
    if (mm.getCurrentLocation != null){
      listMarker.add(
          Marker(
            width: 20,
            height: 20,
            point: LatLng(mm.getCurrentLocation!.latitude!, mm.getCurrentLocation!.longitude!),
            builder: (ctx) => Stack(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,

                    ),
                  ),
                ),

              ],
            ),
          )
      );
    }

    return Stack(
      children: [
        MapWidget(
          listMarker: listMarker,
          mapController: mapController,
          onChanged: (mapPosition, hasGesture) async {
            onPositionChanged(hasGesture);
            Future.delayed(Duration(seconds:1),(){
              mm.setMapPosition = mapPosition;
            });
          },
          onCreated: (mapController){
            Future.delayed(Duration(milliseconds:10),() {
              if (mm.getPlaceToCenter != null){
                centerMapOnPlace(mm.getPlaceToCenter!);
                mm.setPlaceToCenter = null;
              }else{
                centerMap();
              }
            });
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  child: IconButton(
                    key: Key("button"),
                      icon: Icon(
                        (locationStatus == LocationStatus.headingNorth)?Icons.arrow_upward :Icons.my_location,
                        color: (locationStatus == LocationStatus.centred || locationStatus == LocationStatus.headingNorth)?Theme.of(context).colorScheme.secondary: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        centerMap();

                      }
                  )
                ),
                Container(
                  height: 16,
                ),
                ClipRRect(

                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 60,
                    width: 60,
                    color: Theme.of(context).dialogBackgroundColor,
                    child: IconButton(
                      icon: Icon(Icons.list),
                      onPressed: () {
                        _showModalBottomSheet(context);
                      }
                    ),
                  ),
                )
              ],
            )
          )
        ),
        /*(mm.searcherPositionStatus == SearcherPositionStatus.changed)?Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(39),
                  child: Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    child: TextButton(
                      child: Text(t!.searchInThisAreaButton),
                      onPressed: () async {
                        await mm.updateCentersByPosition();
                        await mm.updatePoints();
                      }
                    ),
                  ),
                )
            )
        ):Container()*/
      ],
    );
  }
  void centerMapOnPlace(Place place) {

    setState(() {
      locationStatus = LocationStatus.notCentred;
    });
    mapController.move(LatLng(
        place.lat, place.lng)
        , 13.0);
    mapController.rotate(0);
  }
  void centerMap() {
    if  (locationStatus != LocationStatus.centred) {
      LatLng location =  LatLng(-31.415, -64.183);
      if (mm.getCurrentLocation != null){
        location = LatLng(
            mm.getCurrentLocation!.latitude!, mm.getCurrentLocation!.longitude!);
      }
      mapController.move(location, 13.0);
      mapController.rotate(0);
      setState(() {
        locationStatus = LocationStatus.centred;
      });
    }else{
      LatLng location =  LatLng(-31.415, -64.183);
      if (mm.getCurrentLocation != null){
        location = LatLng(
            mm.getCurrentLocation!.latitude!, mm.getCurrentLocation!.longitude!);
      }
      mapController.move(location, 13.0);

      mapController.rotate((mm.getCurrentLocation != null)
          ? mm.getCurrentLocation!.heading!
          : 0);
      setState(() {
        locationStatus = LocationStatus.headingNorth;
      });
    }
  }
  void onPositionChanged(bool hasGesture){
    if (hasGesture) {
      setState(() {
        locationStatus = LocationStatus.notCentred;
      });
    }else {
      if (locationStatus == LocationStatus.centred) {
        centerMap();
      }
    }

  }
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(

          initialChildSize: 1,
          builder:(BuildContext context,ScrollController myScrollController) {
            return _BottomSheetContent();
          }
        );
      },
    );
  }
}

Future<Location?> getLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

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
  return location;
}

class _BottomSheetContent extends StatefulWidget {
  @override
  __BottomSheetContentState createState() => __BottomSheetContentState();
}

class __BottomSheetContentState extends State<_BottomSheetContent> {
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
  }

  @override
  Widget build(BuildContext context) {
    mm = context.watch<ModelsManager>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              height: 8,
                width:100,
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),


          Expanded(child: getPlaces())
        ],
      ),
    );
  }
  Widget getPlaces(){
    AppLocalizations? t = AppLocalizations.of(context);
    List<Widget> places = [];
    mm.centers.forEach((center){
      String recyclingTypes = "";

      for (int i = 0;i < center.recyclingTypes.length;i++){
        if (i == center.recyclingTypes.length -1){
          recyclingTypes += "${center.recyclingTypes[i].name}";
        }else{
          recyclingTypes += "${center.recyclingTypes[i].name}, ";
        }
      }
      places.add(
        GestureDetector(
          onTap: (){
            mm.selectCenter(center);
            Navigator.of(context)
                .pushNamed("/cooperative");
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(center.name,style: Theme.of(context).textTheme.headline5),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(

                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${t!.cooperative}"),
                              )
                          ),
                        ),
                      )
                    ],
                  ),

                  Row(
                      children:
                      (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day, center.stopTime.hour,center.stopTime.minute, 0).isAfter(DateTime.now()))?
                      [
                      Text("${t.opened}"),
                      Text(" ${t.close}: ${center.stopTime.format(context)}",style:Theme.of(context).textTheme.caption),
                      ]
                          :
                      [
                      Text("${t.closed}", style: TextStyle(color:Theme.of(context).errorColor)),
                      Text(" ${t.open}: ${center.initTime.format(context)}",style:Theme.of(context).textTheme.caption),
                      ]

                  ),
                  Text("${t.recyclingTypes}: $recyclingTypes "),
                  Text("${t.telephone}: ${center.telephone} "),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  OutlinedButton(
                  child: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    mm.setPlaceToCenter = Place(id: center.id, lat:center.lat, lng:center.lng, name: center.name,recyclingTypes:center.recyclingTypes);
                    Navigator.pop(context);
                  }
                  ),
                  Container(width: 8),
                  OutlinedButton(
                  child:Icon(Icons.add),
                  onPressed: () {
                  Deposit deposit = Deposit(place: center, recyclingType: center.recyclingTypes.first);
                  mm.selectDeposit(deposit);
                  Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
                  }
                  ),

                  ],
                  ),
                ],
              ),
            )
          ),
        )
      );
    });
    mm.points.forEach((point){
      String recyclingTypes = "";

      for (int i = 0;i < point.recyclingTypes.length;i++){
        if (i == point.recyclingTypes.length -1){
          recyclingTypes += "${point.recyclingTypes[i].name}";
        }else{
          recyclingTypes += "${point.recyclingTypes[i].name}, ";
        }
      }
      places.add(
          Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: []),
                    Text(point.name,style: Theme.of(context).textTheme.headline5),
                    Text("${t!.recyclingTypes}: $recyclingTypes "),
                    Text("${t.from}: ${point.center.name} "),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            child: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              mm.setPlaceToCenter = Place(id: point.id, lat:point.lat, lng:point.lng, name: point.name,recyclingTypes:point.recyclingTypes);
                              Navigator.pop(context);
                            }
                        ),
                        Container(width: 8),
                        OutlinedButton(
                            child: Icon(Icons.add),

                            onPressed: () {
                              Deposit deposit = Deposit(place: point, recyclingType: point.recyclingTypes.first);
                              mm.selectDeposit(deposit);
                              Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
                            }
                        ),

                      ],
                    ),
                  ],
                ),
              )
          )
      );
    });

    Widget scrollView = SingleChildScrollView(
      child: Column(
        children: places
      ),
    );
    return scrollView;
  }
}

