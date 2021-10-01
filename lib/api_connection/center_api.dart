import 'dart:convert';
import 'package:ecoinclution_proyect/models/center_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/global.dart' as g;

Future<List<CenterModel>> fetchCenters() async {
  User user;
  try{
    user = await g.userRepository.getUser(id: 0);
  }catch (e){
    throw Exception('The user does not exist ');
  }
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/centros/?verificado=true'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );
  print(response.statusCode);

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<CenterModel> list = [];
    try{
      listMap = jsonDecode(response.body);

      listMap.forEach((row) {

        CenterModel centro = CenterModel.fromJson(row);
        list.add(centro);
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
