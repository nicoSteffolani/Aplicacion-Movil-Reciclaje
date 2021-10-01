import 'dart:convert';
import 'package:ecoinclution_proyect/models/deposit_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

Future<List<Deposit>> fetchDeposits() async {
  User user;
  try{
    user = await g.userRepository.getUser(id: 0);
  }catch (e){
    throw Exception('The user does not exist ');
  }
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
      listMap = jsonDecode(response.body);

      listMap.forEach((row) {

        Deposit deposit = Deposit.fromJson(row);
        list.add(deposit);
      });
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }
    return list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + response.body);
  }
}

Future<void> deleteDeposit(Deposit deposit) async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
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
    throw Exception('Error making request. ' + response.body);
  }
}
Future<Deposit> createDeposit(Deposit deposit) async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
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
      Map<String, dynamic> map = jsonDecode(response.body);
      deposit = Deposit.fromJson(map);
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }


    return deposit;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + response.body);
  }
}
Future<Deposit> editDeposit(Deposit deposit) async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
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
      Map<String, dynamic> map = jsonDecode(response.body);
      deposit = Deposit.fromJson(map);
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }


    return deposit;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + response.body);
  }
}