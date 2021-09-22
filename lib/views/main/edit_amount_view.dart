import 'package:ecoinclution_proyect/models/amount_recycle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAmount extends StatelessWidget {
  
  final AmountRecycle amount;
  final bool create;
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _weight = TextEditingController();
  EditAmount({
    required this.amount,
    required this.create,

  });



  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text("Cambiar cantidad y peso."),

      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _amount..text = "${amount.amount}",
              keyboardType: TextInputType.number,
              validator:(val){
                if(val == "" || val == null){
                  return "La cantidad no puede ser nula.";
                }
              },

                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  labelText: "Cantidad: ",
                  hintText: "Cantidad",
              )
            ),
            TextFormField(
              validator:(val){
                if(int.parse(val!) < 1){
                  return "El peso debe ser mayor o igual a 1.";
                }
              },
              controller: _weight..text = "${amount.weight}",
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso total(Kg): ",
                  hintText: "Peso total",
              )
            ),
          ],
        ),
      ),

      actions: <Widget>[
        OutlinedButton( // Diseña el boton
          child: Text(
            "Guardar",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cambiado')),
              );
              Navigator.of(context).pop(AmountRecycle(id: amount.id,amount: _amount.text,weight: _weight.text,deposit: amount.deposit,recycleType:amount.recycleType));
            }
          },
        ),
        OutlinedButton( // Diseña el boton
          child: Text(
            "No guardar",
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            Navigator.of(context).pop(amount);
          },
        ),
      ],
    );
  }
}