import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CooperativePage extends StatefulWidget {

  CooperativePage();

  @override
  _CooperativePageState createState() => _CooperativePageState();
}

class _CooperativePageState extends State<CooperativePage> {
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
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getPoints()
          ),
        )
      )
    );
  }

  List<Widget> getPoints(){
    CenterModel center = mm.selectedCenter;
    AppLocalizations? t = AppLocalizations.of(context);
    List<Widget> list = [];
    list.add(
        Text("${t!.cooperative}", style: Theme.of(context).textTheme.headline4,)
    );
    list.add(
        Text("${center.name}", style: Theme.of(context).textTheme.subtitle1,)
    );
    list.add(
      Divider(height: 0)
    );
    list.add(
      ListTile(
        title: Row(
            children:
            (DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day, center.stopTime.hour,center.stopTime.minute, 0).isAfter(DateTime.now()))?
            [
            Text("${t.opened}"),
            Text(" ${t.close}: ${center.stopTime.format(context)}",style:Theme.of(context).textTheme.caption),
            ]
                :
            [
            Text("${t.closed}", style: TextStyle(color:Theme.of(context).errorColor)),
    Text(" ${t.open}: ${center.initTime.format(context)}",style:Theme.of(context).textTheme.caption),
    ]

    ),
    leading: const Icon(Icons.access_time_outlined)
      )
    );
    list.add(
    Divider(height: 0)
    );
    list.add(
      ListTile(
        title: Text("Lat: ${center.lat}, lng: ${center.lng}"),
        leading: const Icon(Icons.pin_drop)
      )
    );
    list.add(
      Divider(height: 0)
    );
    String recyclingTypes = "";

    for (int i = 0;i < center.recyclingTypes.length;i++){
    if (i == center.recyclingTypes.length -1){
    recyclingTypes += "${center.recyclingTypes[i].name}";
    }else{
    recyclingTypes += "${center.recyclingTypes[i].name}, ";
    }
    }
    list.add(
    ListTile(
    title: Text("${t.recyclingTypes}: $recyclingTypes "),
    leading: const Icon(IconData(0xe900,fontFamily: 'custom'))
    )
    );
    list.add(
    Divider(height: 0)
    );
    List<Widget> points = [];

    mm.points.forEach((point){
      String recyclingTypes = "";

      for (int i = 0;i < point.recyclingTypes.length;i++){
        if (i == point.recyclingTypes.length -1){
        recyclingTypes += "${point.recyclingTypes[i].name}";
        }else{
        recyclingTypes += "${point.recyclingTypes[i].name}, ";
        }
      }
    Card card = Card(
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(children: []),
    Text(point.name,style: Theme.of(context).textTheme.headline5),
    Text("${t.recyclingTypes}: $recyclingTypes "),
    Text("${t.from}: ${point.center.name} "),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    OutlinedButton(
    child: Icon(Icons.remove_red_eye),

    onPressed: () {
    mm.setPlaceToCenter = Place(id: point.id, lat:point.lat, lng:point.lng, name: point.name,recyclingTypes:point.recyclingTypes);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
    ),
    Container(width: 8),
    OutlinedButton(
    child: Icon(Icons.add),

    onPressed: () {
    Deposit deposit = Deposit(place: point, recyclingType: point.recyclingTypes.first);
    mm.selectDeposit(deposit);
    Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true});
    }
    ),

    ],
    ),
    ],
    ),
    )
    );
    points.add(card);
    });
    list.add(
    ExpansionTile(
    leading: const Icon(Icons.map_outlined),
    title: Text("${t.points}"),
    children: points,
    )
    );
    list.add(
    Divider(height: 0)
    );
    List<Widget> intermediaries = [];

    mm.intermediaries.forEach((intermediary){
      print(intermediary.center.name);
    if (intermediary.center.id == center.id){
    intermediaries.add(
    ListTile(
    title: Text(
    '${intermediary.name}'
    ),
    subtitle: Text("${t.telephone}: ${intermediary.phone}"),
    )
    );
    }
    });
    list.add(
    ExpansionTile(
    leading: const Icon(Icons.group),
    title: Text("${t.intermediaries}"),
    children: intermediaries,
    )
    );
    return list;
  }
}

