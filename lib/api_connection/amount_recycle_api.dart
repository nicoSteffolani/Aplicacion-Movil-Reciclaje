import 'dart:convert';
import 'package:ecoinclution_proyect/models/amount_recycle_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

Future<List<AmountRecycle>> fetchAmounts() async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
  });
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/cantidades-reciclado/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );


  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.

    List<dynamic> listMap ;
    List<AmountRecycle> list = [];
    try{
      listMap = jsonDecode(response.body);

      listMap.forEach((row) {

        AmountRecycle amount = AmountRecycle.fromJson(row);
        list.add(amount);
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
Future<AmountRecycle> createAmount(AmountRecycle amount) async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
  });
  print(amount.toDatabaseJson());
  final response = await http.post(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/cantidades-reciclado/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(amount.toDatabaseJson()),

  );


  if (response.statusCode == 201) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    AmountRecycle amount;
    try{
      Map<String, dynamic> map = jsonDecode(response.body);
      amount = AmountRecycle.fromJson(map);
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }


    return amount;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + response.body);
  }
}