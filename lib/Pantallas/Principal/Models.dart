import 'dart:convert';
import 'package:ecoinclution_proyect/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecoinclution_proyect/Global.dart' as g;


Future<List<Intermediario>> fetchIntermediarios() async {
  User user = User();
  await g.userRepository.getUser().then((value) {
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
    List<dynamic> list_map ;
    List<Intermediario> list = [];
    try{
      list_map = jsonDecode(response.body);

      list_map.forEach((row) {

        Intermediario intermediario = Intermediario.fromJson(row);
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

class Intermediario {
  final dynamic url;
  final dynamic id;
  final dynamic nombre;
  final dynamic telefono;
  final dynamic centro;
  final List<dynamic> puntos;
  final List<dynamic> dias;

  Intermediario({
    required this.url,
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.centro,
    required this.puntos,
    required this.dias,
  });

  factory Intermediario.fromJson(Map<String, dynamic> json) {
    return Intermediario(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      centro: json['centro'],
      puntos: json['puntos'],
      dias: json['dias_disponibles'],
    );
  }
}
Future<List<Centro>> fetchCentros() async {
  User user = User();
  await g.userRepository.getUser().then((value) {
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
    List<Centro> list = [];
    try{
      list_map = jsonDecode(response.body);

      list_map.forEach((row) {

        Centro centro = Centro.fromJson(row);
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

class Centro {
  final dynamic url;
  final dynamic id;
  final dynamic nombre;
  final dynamic lat;
  final dynamic long;
  final dynamic telefono;
  final dynamic horarioInicio;
  final dynamic horarioFinal;
  final dynamic verificado;


  Centro({
    required this.url,
    required this.id,
    required this.nombre,
    required this.lat,
    required this.long,
    required this.telefono,
    required this.horarioInicio,
    required this.horarioFinal,
    required this.verificado

  });

  factory Centro.fromJson(Map<String, dynamic> json) {
    return Centro(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      lat: json['lat'],
      long: json['long'],
      telefono: json['telefono'],
      horarioInicio: json['horario_inicio'],
      horarioFinal: json['horario_final'],
      verificado: json['verificado'],

    );
  }
}


