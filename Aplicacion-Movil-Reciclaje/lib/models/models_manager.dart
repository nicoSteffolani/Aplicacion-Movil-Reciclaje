library ecoinclution_proyect.global;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/repository/user_repository.dart';
import 'package:ecoinclution_proyect/api_connection/apis.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

enum ModelsStatus {
  started,
  updating,
  updated,
  error,
  needUser
}
enum SearcherPositionStatus{
  changed,
  centred,
  updating
}
class ModelsManager with ChangeNotifier {
  late MapPosition _mapPosition;
  List<CenterModel> centers = [];
  List<Deposit> deposits = [];
  List<Intermediary> intermediaries = [];
  List<Point> points = [];
  List<RecyclingType> recyclingTypes = [];
  List<Place> places = [];
  LocationData? _currentLocation;
  ModelsStatus modelsStatus = ModelsStatus.started;
  User? user;
  UserRepository userRepository = UserRepository();
  LatLng coordinates = LatLng(0.0,0.0);
  SearcherPositionStatus searcherPositionStatus = SearcherPositionStatus.centred;


  Future<User> authenticateUser({required String username, required String password}) async {
    modelsStatus = ModelsStatus.updating;
    notifyListeners();

    try {
      user = await userRepository.authenticateUser(
          username: username, password: password);
      modelsStatus = ModelsStatus.updated;
      notifyListeners();
      return user!;
    }catch (e){
      modelsStatus = ModelsStatus.updated;
      notifyListeners();
      throw e;
    }
  }
  Future<void> registerUser({
  String username = "",
  String email = "",
  String firstName = "",
  String lastName = "",
  String password = "",
  String password2 = "",
  }) async {
    modelsStatus = ModelsStatus.updating;
    notifyListeners();
    try {
      await userRepository.registerUser(username: username, email: email, firstName:firstName, lastName:lastName,password:password,password2:password2);
      modelsStatus = ModelsStatus.updated;
      notifyListeners();
    }catch (e){
      modelsStatus = ModelsStatus.updated;
      notifyListeners();
      throw e;
    }
  }

  Place? _placeToCenter;
  set setPlaceToCenter(Place? place){
    _placeToCenter = place;
    notifyListeners();
  }

  Place? get getPlaceToCenter {
    return _placeToCenter;
  }

  late Deposit selectedDeposit;
  late CenterModel selectedCenter;

  @override
  void notifyListeners(){
    /*if (modelsStatus == ModelsStatus.updating) {
      Future.delayed(Duration(seconds: 3), () {
        modelsStatus = ModelsStatus.updated;
        super.notifyListeners();
      });
    }*/
    super.notifyListeners();
  }

  void selectDeposit(Deposit deposit) {
    selectedDeposit = deposit;
    notifyListeners();
  }

  void selectCenter(CenterModel center) {
    selectedCenter = center;
    notifyListeners();
  }

  set setCurrentLocation(LocationData locationData){
    _currentLocation = locationData;
    notifyListeners();
  }
  LocationData? get getCurrentLocation {
    return _currentLocation;
  }

  set setMapPosition(MapPosition mapPosition){
    _mapPosition = mapPosition;
    //print("map positition changed: ${_mapPosition.center!.latitude}");
    if (searcherPositionStatus == SearcherPositionStatus.changed){
      coordinates = LatLng(
          _mapPosition.center!.latitude, _mapPosition.center!.longitude);
      notifyListeners();
    }else {
      double tolerance = 0.010;
      double latClamp = _mapPosition.center!.latitude.clamp(
          coordinates.latitude - tolerance, coordinates.latitude + tolerance);
      double longClamp = _mapPosition.center!.longitude.clamp(
          coordinates.longitude - tolerance, coordinates.longitude + tolerance);
      if (latClamp != coordinates.latitude - tolerance &&
          latClamp != coordinates.latitude + tolerance &&
          longClamp != coordinates.longitude - tolerance &&
          longClamp != coordinates.longitude + tolerance) {

      } else {
        if (modelsStatus != ModelsStatus.updating) {
          searcherPositionStatus = SearcherPositionStatus.changed;
          coordinates = LatLng(
              _mapPosition.center!.latitude, _mapPosition.center!.longitude);
          notifyListeners();
        }
      }
    }
  }
  MapPosition get getMapPosition {
    return _mapPosition;
  }
  Future<void> updateCentersByPosition() async {
    searcherPositionStatus = SearcherPositionStatus.updating;
    modelsStatus = ModelsStatus.updating;
    notifyListeners();
    try{
      Future<List<CenterModel>> future = filterCentersByPosition( recyclingTypes: recyclingTypes,user: user!, mm:this);
      centers = await future;

    }catch (e){
      print("centers $e");
    }
    searcherPositionStatus = SearcherPositionStatus.centred;
    modelsStatus = ModelsStatus.updated;
    notifyListeners();

  }
  Future<void> updateCenters() async {
    try{
      Future<List<CenterModel>> future = fetchCenters(recyclingTypes: recyclingTypes,user: user!);
      centers = await future;
    }catch (e){
      print("centers $e");
    }

  }
  Future<void> updatePlaces() async {
    try{
      Future<List<Place>> future = fetchPlaces(recyclingTypes: recyclingTypes,user: user!);
      places = await future;

    }catch (e){
      print("places $e");
    }

  }
  Future<void> updateDeposits() async {
    try{
      Future<List<Deposit>> future = fetchDeposits(places: places, recyclingTypes: recyclingTypes,user: user!);
      deposits = await future;

    }catch (e){
      print("deposits $e");
    }

  }
  Future<void> updateIntermediaries() async {
    try{
      Future<List<Intermediary>> future = fetchIntermediaries(centers: centers, places: places,user: user!);
      intermediaries = await future;

    }catch (e){
      print("intermediaries $e");
    }

  }
  Future<void> updatePointsByPosition() async {
    searcherPositionStatus = SearcherPositionStatus.updating;
    modelsStatus = ModelsStatus.updating;
    notifyListeners();
    try{
      Future<List<Point>> future = filterPointsByPosition(centers: centers, recyclingTypes: recyclingTypes,user: user!, mm:this);
      points = await future;

    }catch (e){
      print("points $e");
    }
    modelsStatus = ModelsStatus.updated;
    searcherPositionStatus = SearcherPositionStatus.centred;
    notifyListeners();

  }
  Future<void> updatePoints() async {
    try{
      Future<List<Point>> future = fetchPoints(centers: centers, recyclingTypes: recyclingTypes,user: user!);
      points = await future;

    }catch (e){
      print("points $e");
    }

  }
  Future<void> updateRecyclingTypes()  async {
    try{
      Future<List<RecyclingType>> future = fetchRecyclingTypes(user: user!);
      recyclingTypes = await future;

    }catch (e){
      print("types $e");
    }

  }

  Future<void> updateUser() async {
    user = await userRepository.getUser(id: 0);
  }

  Future<void> updateAll() async {
    modelsStatus = ModelsStatus.updating;
    notifyListeners();
    try {
      await updateUser();
      await updateRecyclingTypes();
      await updatePlaces();
      await updateCenters();
      await updatePoints();
      await updateDeposits();
      await updateIntermediaries();

      modelsStatus = ModelsStatus.updated;
      notifyListeners();
    } catch (e) {
      print("There is no user$e");
      modelsStatus = ModelsStatus.needUser;
      notifyListeners();
    }
  }

  void removeDeposit(Deposit deposit) {
    deleteDeposit(deposit);
    modelsStatus = ModelsStatus.updating;
    notifyListeners();
  }
}

UserRepository userRepository = UserRepository();