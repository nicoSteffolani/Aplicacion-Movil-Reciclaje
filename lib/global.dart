library ecoinclution_proyect.global;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecoinclution_proyect/repository/user_repository.dart';

import 'package:ecoinclution_proyect/api_connection/apis.dart';
import 'package:ecoinclution_proyect/models/models.dart';


class Models {
  List<CenterModel> centers = [];
  List<Deposit> deposits = [];
  List<Intermediary> intermediarys = [];
  List<Point> points = [];
  List<RecycleType> types = [];

  Future<List<CenterModel>> updateCenters() async {
    Future<List<CenterModel>> future = fetchCenters();
    centers = await future;
    return future;
  }
  Future<List<Deposit>> updateDeposits() async {
    Future<List<Deposit>> future = fetchDeposits();
    deposits = await future;
    return future;
  }
  Future<List<Intermediary>> updateIntermedirys() async {
    Future<List<Intermediary>> future = fetchIntermediarys();
    intermediarys = await future;
    return future;
  }
  Future<List<Point>> updatePoints() async {
    Future<List<Point>> future = fetchPoints();
    points = await future;
    return future;
  }
  Future<List<RecycleType>> updateRecycleTypes() async {
    Future<List<RecycleType>> future = fetchRecycleTypes();
    types = await future;
    return future;
  }
  Future<void> updateAll() async {
    try {
      await updateCenters();
      await updateDeposits();
      await updateIntermedirys();
      await updatePoints();
      await updateRecycleTypes();
    }
    catch (e){
      print("erroe en el update");
    }
  }
}

Models models = Models();
GoogleSignInAccount? user;
UserRepository userRepository = UserRepository();