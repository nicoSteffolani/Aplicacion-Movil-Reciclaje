import 'package:animations/animations.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'cooperatives_tab_view.dart';
import 'depostits_tab_view.dart';
import 'map_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
// Creo un espacio en donde puedo iniciar cualquier ventana de la lista, mostrando en todas ellas el menu inferior
class HomePage extends StatefulWidget {
  final int? pageIndex;

  const HomePage({Key? key,
    this.pageIndex,
  }): super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool left = false;
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
    if (this.widget.pageIndex != null){
      pageIndex = this.widget.pageIndex!;
      print(this.widget.pageIndex);
    }
    Future.delayed(Duration(milliseconds: 1),(){
      if (mm.modelsStatus == ModelsStatus.started) {
        mm.updateAll();
      }
    });
    getLocation().then((location){
      if (location != null) {
        location.onLocationChanged.listen((LocationData currentLocation) {
          // Use current location
          mm.setCurrentLocation = currentLocation;
        });
      }
    });
  }
  // Lista de ventanas que puedo mostrar
  int pageIndex = 0; //Indica que venta se muestra por defecto
  List<Widget> pageList = <Widget>[
    MapPage(),
    CooperativesPage(),
    DepositsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    var begin = Offset((left)? 1.0 : -1.0, 0.0);
    const end =  Offset(0.0, 0.0);
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
        SlideTransition(
          position: primaryAnimation.drive(tween),
          child: pageList[pageIndex],
        ),
        child: pageList[pageIndex], // Indica que ventana tiene que mostrar
      ),
      
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomNavigationBar( //Se crea la barra de menu inferior
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: (value) { // Toma el valor posicional del boton en un vector de donde estan todos los botones
            setState(() {

              if (pageIndex > value){
                left = false;
              }else{
                left = true;
              }
              pageIndex = value;
            });
          },
          items: [ // Se tiene que tener la misma cantidad de items que de ventas
            BottomNavigationBarItem(
              icon: Icon(Icons.map_sharp),
              label: t!.mapTitle, // Esta vairable tiene que estar definida, no puede ser null
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: t.cooperatives,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: t.deposits,
            ),
          ],
        ),
      )
    );
  }
}
