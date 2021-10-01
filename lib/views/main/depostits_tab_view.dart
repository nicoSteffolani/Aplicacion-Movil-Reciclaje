import 'dart:async';

import 'package:ecoinclution_proyect/api_connection/deposit_api.dart';
import 'package:ecoinclution_proyect/models/deposit_model.dart';
import 'package:ecoinclution_proyect/models/models.dart';
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
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
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
                  gravity: ToastGravity.CENTER,
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

                          deleteDeposit(list[index]).then((_) {
                            list.removeAt(index);
                          });
                        },
                        confirmDismiss: (direction) async {
                          bool result = await showDialog(context: context,builder: (_) => DeleteDeposit());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deposito ${index + 1} Eliminado.'),
                                action: SnackBarAction(label: "Deshacer",onPressed:()=>result=false)),
                          );
                          await Future.delayed(Duration(seconds: 3));
                          return result;
                        },
                        background: Container(
                            color: Colors.red,
                            padding: EdgeInsets.only(left: 16),
                            child: Align(child:const Icon(Icons.delete),alignment: Alignment.centerLeft,)
                        ),
                        child: ListTile(
                          title: Text(
                              'Deposito N°${index + 1}'
                          ),
                          subtitle: Text("Fecha: ${list[index].date}"),
                          leading: IconButton(
                            icon: const Icon(Icons.info,),
                            onPressed: () {
                              Place? place;
                              g.models.points.forEach((point){
                                if (list[index].place == point.id){
                                  place = point;
                                }
                              });
                              if (place == null){
                                g.models.centers.forEach((center){
                                  if (list[index].place == center.id){
                                    place = center;
                                  }
                                });
                              }
                              RecycleType? type;
                              g.models.types.forEach((element){
                                if (list[index].recycleType == element.id){
                                  type = element;
                                }
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
                                      leading: const Icon(Icons.location_pin),
                                      title: Text("Lugar"),
                                      subtitle : Text("${place!.name}")
                                    ),
                                    ListTile(
                                        leading: const Icon(IconData(0xe900,fontFamily: 'custom')),
                                        title: Text("Tipo de reciclado"),
                                        subtitle : Text("${type!.name}")
                                    ),
                                    ListTile(
                                      leading: const Icon(IconData(0xe902,fontFamily: 'custom')),
                                      title: Text("Cantidad"),
                                      subtitle : Text("${list[index].amount}")
                                    ),
                                    ListTile(
                                      leading: const Icon(IconData(0xe901,fontFamily: 'custom')),
                                        title: Text("Peso "),
                                        subtitle : Text("${list[index].weight} Kg")
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  OutlinedButton(
                                    child: Text(
                                      "Cerrar",
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
                return Text("No tienes depositos toca el '+' para agregar uno.");
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
