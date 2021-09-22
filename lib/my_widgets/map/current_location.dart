import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:flutter/material.dart';
import 'package:location/location.dart';


 class CurrentLocation  {

  Future<LocationData?> getLocation(BuildContext context) async {

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
    print(g.location);
    return _locationData;
    g.location = _locationData;


  }

}
