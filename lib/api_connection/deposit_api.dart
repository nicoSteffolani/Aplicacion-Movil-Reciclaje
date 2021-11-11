import 'dart:convert';
import 'package:ecoinclution_proyect/models/deposit_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/repository/user_repository.dart';
import 'package:http/http.dart' as http;

Future<List<Deposit>> fetchDeposits({required List<RecyclingType> recyclingTypes, required List<Place> places,required User user}) async {

  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/depositos/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );
  print(response.statusCode);

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.

    List<dynamic> listMap ;
    List<Deposit> list = [];
    try{
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try{
          Deposit deposit = Deposit.fromJson(row, places: places,recyclingTypes: recyclingTypes);
          list.add(deposit);
        }catch (e){
          print("deposits error  $e");
        }
      });
    } catch (e) {
      throw Exception("cant decode body. /deposit_api/ " + e.toString());
    }
    return list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}

Future<void> deleteDeposit(Deposit deposit) async {
  UserRepository userRepository = UserRepository();
  User user = User();
  await userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. /deposit_api/ ' + error);
  });
  final response = await http.delete(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/depositos/${deposit.id}/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );


  if (response.statusCode == 204) {
    print("Deposit ${deposit.id} deleted.");
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error making request. ' + utf8.decode(response.bodyBytes));
  }
}
Future<Deposit> createDeposit(Deposit deposit,{required List<RecyclingType> recyclingTypes, required List<Place> places}) async {
  UserRepository userRepository = UserRepository();
  User user = User();
  await userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. /deposit_api/ ' + error);
  });
  print(deposit.toDatabaseJson());
  final response = await http.post(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/depositos/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(deposit.toDatabaseJson()),

  );


  if (response.statusCode == 201) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    Deposit deposit;
    try{
      Map<String, dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
      deposit = Deposit.fromJson(map, places: places,recyclingTypes: recyclingTypes);
    } catch (e) {
      throw Exception("cant decode body. /deposit_api/ " + e.toString());
    }


    return deposit;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}
Future<Deposit> editDeposit(Deposit deposit,{required List<RecyclingType> recyclingTypes, required List<Place> places}) async {
  UserRepository userRepository = UserRepository();
  User user = User();
  await userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. /deposit_api/ ' + error);
  });
  print(deposit.toDatabaseJson());
  final response = await http.put(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/depositos/${deposit.id}/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(deposit.toDatabaseJson()),

  );
  print(response.statusCode);

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    Deposit deposit;
    try{
      Map<String, dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
      deposit = Deposit.fromJson(map, places: places,recyclingTypes: recyclingTypes);
    } catch (e) {
      throw Exception("cant decode body. /deposit_api/ " + e.toString());
    }


    return deposit;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}