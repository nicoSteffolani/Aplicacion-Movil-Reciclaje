import 'dart:convert';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:http/http.dart' as http;

Future<List<RecyclingType>> fetchRecyclingTypes({required User user}) async {
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/tipos-de-reciclado/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    print("tipos obtenidos");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<RecyclingType> list = [];
    try{
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {

        RecyclingType type = RecyclingType.fromJson(row);
        list.add(type);
      });
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }
    return list;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}