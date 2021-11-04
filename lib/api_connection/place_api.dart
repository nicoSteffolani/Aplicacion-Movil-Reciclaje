import 'dart:convert';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:http/http.dart' as http;


Future<List<Place>> fetchPlaces({required List<RecyclingType> recyclingTypes,required User user}) async {
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/lugares/'),
    headers: <String, String>{
      'Authorization': 'token ' + user.token,
    },

  );
  print(response.statusCode);

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> listMap ;
    List<Place> list = [];
    try{
      listMap = jsonDecode(utf8.decode(response.bodyBytes));

      listMap.forEach((row) {
        try {
          Place place = Place.fromJson(row, recyclingTypes: recyclingTypes);
          list.add(place);
        }catch (e){
          print("places error  $e");
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
