import 'dart:convert';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/intermediary_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:http/http.dart' as http;


Future<List<Intermediary>> fetchIntermediaries({required List<Place> places, required List<CenterModel> centers,required User user}) async {
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
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try{
          Intermediary intermediary = Intermediary.fromJson(row,places: places, centers: centers);
          list.add(intermediary);
        }catch (e){
          print("Intermediary error  $e");
        }
      });
    } catch (e) {
      throw Exception("cant decode body. /intermediary_api/" + e.toString());
    }
    return list;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}