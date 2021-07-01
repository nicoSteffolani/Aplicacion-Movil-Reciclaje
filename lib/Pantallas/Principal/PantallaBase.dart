import 'package:animations/animations.dart';
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
    ListDisplay(), //TODO diseñar la ventana de coperativas
    PaginaDepositos(), //TODO diseñar la ventana de depositos
    PaginaUsuario(), //TODO diseñar la ventana de usuario

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
        FadeThroughTransition( // esto le agrega una animacion cuando cambias de ventanas
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pageList[pageIndex], // Indica que ventana tiene que mostrar
      ),
      bottomNavigationBar: BottomNavigationBar( //Se crea la barra de menu inferior
        selectedIconTheme: IconThemeData(
          size: 35,
          color: kColorPrimario,
        ),
        unselectedIconTheme: IconThemeData(
          color: kBlanco,
        ),
        type: BottomNavigationBarType.fixed,
        backgroundColor: kNegroClaro,
        currentIndex: pageIndex,
        onTap: (value) { // Toma el valor posicional del boton en un vector de donde estan todos los botones
          setState(() {
            pageIndex = value;
          });
        },
        items: [ // Se tiene que tener la misma cantidad de items que de ventas
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_sharp,
            ),
            label: "", // Esta vairable tiene que estar definida, no puede ser null
            tooltip: "Mapa", // Cuando se mantiene apretado el boton por un periodo de tiempo, este texto aparece arriba del mismo
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
