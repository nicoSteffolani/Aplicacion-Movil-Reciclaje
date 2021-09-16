import 'package:animations/animations.dart';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:ecoinclution_proyect/views/main/user_tab_view.dart';
import 'package:flutter/material.dart';
import 'cooperatives_tab_view.dart';
import 'depostits_tab_view.dart';
import 'map_tab_view.dart';
import 'package:ecoinclution_proyect/Global.dart' as g;

// Creo un espacio en donde puedo iniciar cualquier ventana de la lista, mostrando en todas ellas el menu inferior
class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Lista de ventanas que puedo mostrar
  int pageIndex = 0; //Indica que venta se muestra por defecto
  List<Widget> pageList = <Widget>[

    MapPage(),
    CooperativesPage(),
    DepositsPage(),
    UserPage(), //TODO diseñar la ventana de usuario

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded),
            onPressed: () async {
              await g.userRepository.getUser(id: 0).then((value) async {
                var user = value;
                currentTheme.toggleThemeBool(!(user.theme));
                await g.userRepository.updateUser(user: User(id: user.id, username: user.username,token: user.token,theme: !(user.theme)));
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
        FadeScaleTransition( // esto le agrega una animacion cuando cambias de ventanas
          animation: primaryAnimation,

          child: child,
        ),
        child: pageList[pageIndex], // Indica que ventana tiene que mostrar
      ),
      bottomNavigationBar: BottomNavigationBar( //Se crea la barra de menu inferior
        currentIndex: pageIndex,
        onTap: (value) { // Toma el valor posicional del boton en un vector de donde estan todos los botones
          setState(() {
            pageIndex = value;
          });
        },
        items: [ // Se tiene que tener la misma cantidad de items que de ventas
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp),
            label: "Mapa", // Esta vairable tiene que estar definida, no puede ser null
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            label: "Cooperativas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Depositos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: "Usuario",

          ),
        ],
      ),
    );
  }
}
