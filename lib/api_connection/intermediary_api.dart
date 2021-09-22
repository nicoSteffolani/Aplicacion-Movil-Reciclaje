import 'dart:convert';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/intermediary_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/global.dart' as g;


Future<List<Intermediary>> fetchIntermediarys() async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
  });
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/intermediarios/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<Intermediary> list = [];
    try{
      listMap = jsonDecode(response.body);

      listMap.forEach((row) {

        Intermediary intermediario = Intermediary.fromJson(row);
        list.add(intermediario);
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