import 'dart:convert';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:http/http.dart' as http;

Future<List<CenterModel>> fetchCenters({required List<RecyclingType> recyclingTypes,required User user}) async {

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
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try {
          CenterModel centro = CenterModel.fromJson(
              row, recyclingTypes: recyclingTypes);
          list.add(centro);
        }catch (e){
          print("Center error  $e");
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
Future<List<CenterModel>> filterCentersByPosition( {required List<RecyclingType> recyclingTypes, required User user,required ModelsManager mm}) async {
  print('http://ecoinclusion.herokuapp.com/api/centros/?long_min=${mm.getMapPosition.bounds!.west}&long_max=${mm.getMapPosition.bounds!.east}&lat_min=${mm.getMapPosition.bounds!.south}&lat_max=${mm.getMapPosition.bounds!.north}&verificado=true');
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/centros/?long_min=${mm.getMapPosition.bounds!.west}&long_max=${mm.getMapPosition.bounds!.east}&lat_min=${mm.getMapPosition.bounds!.south}&lat_max=${mm.getMapPosition.bounds!.north}&verificado=true'),
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
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {

        CenterModel centro = CenterModel.fromJson(row, recyclingTypes: recyclingTypes);
        list.add(centro);
      });
    } catch (e) {
      throw Exception("cant decode body. /center_api/ " + e.toString());
    }
    return list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('error on making request. ' + utf8.decode(response.bodyBytes));
  }
}
