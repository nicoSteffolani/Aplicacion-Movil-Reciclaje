import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/model/api_model.dart';

final _base = "http://ecoinclusion.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final _tokenURL = _base + _tokenEndpoint;
final Uri uri = Uri.parse(_tokenURL);
Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  print("request made");
  if (response.statusCode == 200) {
    print(response.body);
    return Token.fromJson(json.decode(response.body));
  } else {
    print("error");
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
