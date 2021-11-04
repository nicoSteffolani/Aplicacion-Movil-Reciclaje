import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CooperativesPage extends StatefulWidget {
  const CooperativesPage({Key? key}) : super(key: key);

  @override
  _CooperativesPageState createState() => _CooperativesPageState();
}

class _CooperativesPageState extends State<CooperativesPage> {
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
  }
  String formatTime(String time){
    DateTime dateTime = DateTime.parse('2021-01-01 $time');
    return '${dateTime.hour}:${dateTime.minute}0';
  }
  @override
  Widget build(BuildContext context) {
    mm = context.watch<ModelsManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooperativas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: (mm.modelsStatus == ModelsStatus.updating)?Align(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/gifs/loading.gif",
          width: 200, // con estas proporciones
          height: 200,
        ),
      ):SingleChildScrollView(
        child: Column(
          children: getCenters()
        )
      )
    );
  }
  List<Widget> getCenters() {
    AppLocalizations? t = AppLocalizations.of(context);
    List<Widget> list = [];

    mm.centers.forEach((center){
      String recyclingTypes = "";

      for (int i = 0;i < center.recyclingTypes.length;i++){
        if (i == center.recyclingTypes.length -1){
          recyclingTypes += "${center.recyclingTypes[i].name}";
        }else{
          recyclingTypes += "${center.recyclingTypes[i].name}, ";
        }
      }
      List<Widget> placeOpen = (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day, center.stopTime.hour,center.stopTime.minute, 0).isAfter(DateTime.now()))?
      [
      Text("${t!.opened}"),
      Text(" ${t.close}: ${center.stopTime.format(context)}",style:Theme.of(context).textTheme.caption),
      ]
          :
      [
      Text("${t!.closed}", style: TextStyle(color:Theme.of(context).errorColor)),
      Text(" ${t.open}: ${center.initTime.format(context)}",style:Theme.of(context).textTheme.caption),
      ];
      list.add(
        GestureDetector(
          onTap: (){
            mm.selectCenter(center);
            Navigator.of(context)
                .pushNamed("/cooperative");
          },
          child: Card(
            child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(center.name,style: Theme.of(context).textTheme.headline5),
                  Row(
                    children:placeOpen
                  ),
                  Text("${t.recyclingTypes}: $recyclingTypes "),
                  Text("${t.telephone}: ${center.telephone} "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        icon: Icon(Icons.remove_red_eye),
                        label: Text(t.viewOnMap),
                        onPressed: () {
                          mm.setPlaceToCenter = Place(id: center.id, lat:center.lat, lng:center.lng, name: center.name,recyclingTypes:center.recyclingTypes);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                        }
                      ),
                      Container(width: 8),
                      OutlinedButton.icon(
                        icon: Icon(Icons.add),
                        label: Text(t.addDepositButton),
                        onPressed: () {
                          Deposit deposit = Deposit(place: center, recyclingType: center.recyclingTypes.first);
                          mm.selectDeposit(deposit);
                          Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
                        }
                      ),

                    ],
                  ),

                ],
              ),
            )
          ),
        )
      );
    });

    return list;
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[


        ListTile(
          title: Text("Los cuadrados"),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
