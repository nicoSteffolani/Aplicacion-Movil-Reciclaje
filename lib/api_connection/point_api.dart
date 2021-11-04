import 'dart:convert';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:ecoinclution_proyect/models/point_model.dart';
import 'package:http/http.dart' as http;

Future<List<Point>> fetchPoints( {required List<RecyclingType> recyclingTypes, required List<CenterModel> centers,required User user}) async {

  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/puntos/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    print("puntos obtenidos");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<Point> list = [];
    try{
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try {
          Point point = Point.fromJson(
              row, recyclingTypes: recyclingTypes, centers: centers);
          list.add(point);
        }catch (e){
          print("Point error  $e");
        }
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
Future<List<Point>> filterPointsByPosition( {required List<RecyclingType> recyclingTypes, required List<CenterModel> centers,required User user,required ModelsManager mm}) async {
  print('http://ecoinclusion.herokuapp.com/api/puntos/?long_min=${mm.getMapPosition.bounds!.west}&long_max=${mm.getMapPosition.bounds!.east}&lat_min=${mm.getMapPosition.bounds!.south}&lat_max=${mm.getMapPosition.bounds!.north}');
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/puntos/?long_min=${mm.getMapPosition.bounds!.west}&long_max=${mm.getMapPosition.bounds!.east}&lat_min=${mm.getMapPosition.bounds!.south}&lat_max=${mm.getMapPosition.bounds!.north}'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    print("Puntos filtrado por posision");
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<Point> list = [];
    try{
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try {
          Point point = Point.fromJson(
              row, recyclingTypes: recyclingTypes, centers: centers);
          list.add(point);
        }catch (e){

        }
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
