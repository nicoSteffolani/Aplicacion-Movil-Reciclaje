import 'dart:convert';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

Future<List<CenterModel>> fetchCenters() async {
  User user = User();
  await g.userRepository.getUser(id: 0).then((value) {
    print("ok");
    user = value;
  }, onError: (error) {
    throw Exception('Failed to get user. ' + error);
  });
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/centros/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> list_map ;
    List<CenterModel> list = [];
    try{
      list_map = jsonDecode(response.body);

      list_map.forEach((row) {

        CenterModel centro = CenterModel.fromJson(row);
        list.add(centro);
      });
    } catch (e) {
      throw Exception("cant decode body. " + e.toString());
    }

    print(list);
    return list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + response.body);
  }
}
