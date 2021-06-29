import 'package:ecoinclution_proyect/Constants.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/Coperativas.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/Depositos.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/Mapa.dart';
import 'package:ecoinclution_proyect/Pantallas/Principal/Usuario.dart';
import 'package:flutter/material.dart';


// Creo un espacio en donde puedo iniciar cualquier ventana de la lista, mostrando en todas ellas el menu inferior
class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key key}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  // Lista de ventanas que puedo mostrar
  int pageIndex = 0; //Indica que venta se muestra por defecto
  List<Widget> pageList = <Widget>[

    Mapa(),
    PaginaCoperativa(),
    PaginaDepositos(),
    PaginaUsuario(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: pageList[pageIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          size: 35,
          color: kColorPrimario,
        ),
        unselectedIconTheme: IconThemeData(
          color: kBlanco,
        ),
        // unselectedLabelStyle: TextStyle(color: kBlanco,),
        type: BottomNavigationBarType.fixed,
        backgroundColor: kNegroClaro,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: [ //
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_sharp,
            ),
            label: "",
            tooltip: "Mapa",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.group_rounded,
              ),
              label: "",
              backgroundColor: kBlanco,
              tooltip: "Cooperativas"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_to_drive,
              ),
              label: "",
              backgroundColor: kBlanco,
              tooltip: "Depositos"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
            ),
            label: "",
            tooltip: "Usuario",
            backgroundColor: kBlanco,
          ),
        ],
      ),
    );
  }
}
