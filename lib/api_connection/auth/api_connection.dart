import 'dart:async';
import 'dart:convert';
import 'package:ecoinclution_proyect/models/auth/api_model.dart';
import 'package:http/http.dart' as http;

final _base = "https://ecoinclusion.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final _tokenURL = _base + _tokenEndpoint;
final Uri tokenUri = Uri.parse(_tokenURL);

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    tokenUri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  print("request made /api_conection/");
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    return Token.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print(" Error ${response.statusCode} ");
    print(json.decode(utf8.decode(response.bodyBytes)));
    throw json.decode(utf8.decode(response.bodyBytes));
  }
}
final _registerEndpoint = "/api/register/";
final _registerURL = _base + _registerEndpoint;
final Uri registerUri = Uri.parse(_registerURL);

Future<Map<String,dynamic>> postUser(UserRegister userRegister) async {
  print(_registerURL);
  final http.Response response = await http.post(
    registerUri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userRegister.toDatabaseJson()),
  );

  print("request made ${userRegister.toDatabaseJson()} /api_conection/");
  if (response.statusCode == 201) {
    print(utf8.decode(response.bodyBytes));
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    print("error ${response.statusCode} /api_conection/");
    throw json.decode(utf8.decode(response.bodyBytes));
  }
}
