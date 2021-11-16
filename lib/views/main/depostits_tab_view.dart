import 'dart:async';
import 'package:ecoinclution_proyect/models/deposit_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:flutter/material.dart';import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class DepositsPage extends StatefulWidget {
  const DepositsPage({Key? key}) : super(key: key);

  @override
  _DepositsPageState createState() => _DepositsPageState();
}

class _DepositsPageState extends State<DepositsPage> {
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    Fluttertoast.showToast(
      msg: "Desliza un deposito para eliminarlo.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
    mm = context.read<ModelsManager>();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    mm = context.watch<ModelsManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text(t!.deposits),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
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
            children: getDeposits(),
          )
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        onPressed: () {

          Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": true,"deposit":null});
        },
      ),
    );
  }

  List<Widget> getDeposits(){
    AppLocalizations? t = AppLocalizations.of(context);
    List<Widget> depositsList = [];

    for (int i = 0;i< mm.deposits.length;i++) {
      Deposit deposit = mm.deposits[i];
      Dismissible dismissible = Dismissible(
        key: ValueKey(deposit.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) async {
          mm.removeDeposit(deposit);
          mm.deposits.remove(deposit);
          await Future.delayed(Duration(seconds:1));
          mm.updateAll();
        },
        confirmDismiss: (direction) async {
          bool? result = await showDialog(
              context: context, builder: (_) => DeleteDeposit());
          if (result != null && result) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Deposito ${i + 1} Eliminado.'),
                  action: SnackBarAction(
                      label: "Deshacer", onPressed: () => result = false)),
            );
            await Future.delayed(Duration(seconds: 3));
          }else{
            result = false;
          }
          return result;
        },
        background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(left: 16),
            child: Align(
              child: const Icon(Icons.delete), alignment: Alignment.centerLeft,)
        ),
        child: ListTile(
          title: Text("${t!.depositOf} ${deposit.recyclingType.name}"),
          subtitle: Text("${t.date}: ${deposit.date}"),
          leading: IconButton(
            icon: const Icon(Icons.info,),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return DepositInfo(deposit:deposit, index: i);
              });
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit,),
            onPressed: () {
              mm.selectDeposit(deposit);
              Navigator.of(context).pushNamed("/edit_deposit", arguments: {
                "create": false,
              });
            },
          ),

        ),
      );
      depositsList.add(dismissible);
    }
    return depositsList;
  }
}
class DeleteDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    AppLocalizations? t = AppLocalizations.of(context);
    return AlertDialog(
      title: Text("Estas seguro de que quieres eliminar este deposito?"),
      actions: <Widget>[
        OutlinedButton( // Diseña el boton
          child: Text(t!.closeButton),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        OutlinedButton( // Diseña el boton
          child: Text(t.acceptButton),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
class DepositInfo extends StatefulWidget {
  final int index;
  final Deposit deposit;
  DepositInfo({Key? key, required this.index, required this.deposit}) : super(key: key);

  @override
  _DepositInfoState createState() => _DepositInfoState();
}

class _DepositInfoState extends State<DepositInfo> {
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
  }

  @override
  Widget build(BuildContext context){
    AppLocalizations? t = AppLocalizations.of(context);
    return AlertDialog(
      scrollable: true,
      title: Text("${t!.depositOf} ${widget.deposit.recyclingType.name}"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              leading: const Icon(Icons.date_range),
              title: Text(t.dateToDeposit),
              subtitle: Text("${widget.deposit.date}")
          ),
          ListTile(
              leading: const Icon(Icons.location_pin),
              title: Text(t.place),
              subtitle: Text("${widget.deposit.place.name}"),
              onTap: () {
                mm.setPlaceToCenter = widget.deposit.place;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              }
          ),
          ListTile(
              leading: Icon(
                  IconData(0xe900, fontFamily: 'custom'),color: Theme.of(context).colorScheme.secondary),
              title: Text(t.recyclingType),
              subtitle: Text("${widget.deposit.recyclingType.name}")
          ),
          ListTile(
              leading: const Icon(
                  IconData(0xe902, fontFamily: 'custom')),
              title: Text(t.amount),
              subtitle: Text("${widget.deposit.amount}")
          ),
          ListTile(
              leading: const Icon(
                  IconData(0xe901, fontFamily: 'custom')),
              title: Text(t.weight),
              subtitle: Text("${widget.deposit.weight} Kg")
          ),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          child: Text(t.closeButton),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}