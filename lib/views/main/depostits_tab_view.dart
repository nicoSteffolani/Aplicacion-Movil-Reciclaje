import 'package:ecoinclution_proyect/api_connection/deposit_api.dart';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:ecoinclution_proyect/models/deposit_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:fluttertoast/fluttertoast.dart';

import 'deposit_delete_view.dart';


class DepositsPage extends StatelessWidget {
  const DepositsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Depositos"),
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
      body: Center(
        child: FutureBuilder<List<Deposit>>(
          future:  g.models.updateDeposits(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length != 0){
                Fluttertoast.showToast(
                  msg: "Desliza un deposito para eliminarlo.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                );
                List<Deposit> list = snapshot.data!;
                return Scrollbar(
                  child: ListView.separated(
                    separatorBuilder: (_,__) => Divider(height: 1),
                    itemBuilder: (_,index) {
                      return Dismissible(
                        key: ValueKey(list[index].id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          deleteDeposit(list[index]);
                        },
                        confirmDismiss: (direction) async {
                          final result = await showDialog(context: context,builder: (_) => DeleteDeposit());
                          return result;
                        },
                        background: Container(
                            color: Colors.red,
                            padding: EdgeInsets.only(left: 16),
                            child: Align(child:const Icon(Icons.delete),alignment: Alignment.centerLeft,)
                        ),
                        child: ListTile(
                          title: Text(
                              'Deposito N°${list[index].id}'
                          ),
                          subtitle: Text("Fecha: ${list[index].date}"),
                          leading: IconButton(
                            icon: const Icon(Icons.info,),
                            onPressed: () {
                              CenterModel? center;
                              g.models.centers.forEach((element){
                                if (element.id == list[index].center){
                                  center = element;
                                }
                              });
                              Point? point;
                              g.models.points.forEach((element){
                                if (element.id == list[index].point){
                                  point = element;
                                }
                              });
                              List<AmountRecycle> amounts = [];
                              List<RecycleType> types = [];
                              g.models.amounts.forEach((amount){
                                bool inserted = false;
                                g.models.types.forEach((type){
                                  if (amount.deposit == list[index].id && amount.recycleType == type.id && !inserted){
                                    amounts.add(amount);
                                    types.add(type);
                                    inserted = true;
                                  }
                                });
                              });
                              AlertDialog info =  AlertDialog(
                                title: Text('Deposito N°${list[index].id}'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.date_range),
                                      title: Text("Fecha a depositar"),
                                      subtitle : Text("${list[index].date}")
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.house),
                                      title: Text("Cooperativa ${center!.nombre}"),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.location_pin),
                                      title: Text("Punto ${point!.name}"),
                                    ),
                                    Divider(thickness: 2,),
                                    Expanded(
                                      child:ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        separatorBuilder: (_,__) => Divider(),
                                        itemBuilder: (_,index) {
                                          return ListTile(
                                            title: Text(
                                                'Tipo de reciclado: ${types[index].name}'
                                            ),
                                            subtitle: Text("Cantidad: ${amounts[index].amount}, peso total ${amounts[index].weight}Kg"),
                                          );
                                        },
                                        itemCount: amounts.length,
                                      )
                                    ),

                                  ],
                                ),
                                actions: <Widget>[
                                  OutlinedButton( // Diseña el boton
                                    child: Text(
                                      "Cerrar",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                              showDialog(context: context, builder:(context){
                                return info;
                              });

                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit,),
                            onPressed: () {
                              Navigator.of(context).pushNamed("/edit_deposit",arguments: {"create": false,"deposit": list[index].toDatabaseJson()});
                            },
                          ),

                        ),
                      );
                    },
                    itemCount: list.length,
                  ),
                );
              }else{
                return Text("No tienes depositos toca el '+' para agregar uno");
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
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
}
