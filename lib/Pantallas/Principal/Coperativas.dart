import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('http://ecoinclusion.herokuapp.com/api/intermediarios/191 '),

    headers: {
      HttpHeaders.authorizationHeader: 'token 335cca20e5cf7060586db83e74d9098657f48c7c'
    },
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String url;
  final int id;
  final String nombre;
  final String telefono;
  final int centro;
  // final List<int> puntos;
  // final List<String> dias;

  Album({
    required this.url,
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.centro,
    // required this.puntos,
    // required this.dias,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      centro: json['centro'],
      // puntos: json['puntos'],
      // dias: json['dias_disponibles'],
    );
  }
}

class FetchedData extends StatefulWidget {
  const FetchedData({Key? key}) : super(key: key);

  @override
  _FetchedDataState createState() => _FetchedDataState();
}

class _FetchedDataState extends State<FetchedData> {

  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var centro = snapshot.data!.centro;
              var nombre = snapshot.data!.nombre;
              return Text("El $nombre del centro numero $centro");
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
