import 'package:ecoinclution_proyect/api_connection/apis.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/models_manager.dart';
import 'package:ecoinclution_proyect/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditDepositPage extends StatefulWidget {
  final bool create;

  const EditDepositPage({Key? key,
    required this.create
  }): super(key: key);

  @override
  _EditDepositPageState createState() => _EditDepositPageState();
}
class _EditDepositPageState extends State<EditDepositPage> {
  late ModelsManager mm;

  @override
  initState() {
    super.initState();
    mm = context.read<ModelsManager>();
    try{
      
      mm.places.forEach((place){
        if (mm.selectedDeposit.place.id == place.id){
          _selectedPlace = place;
        }
      });
    }catch(e){
      print("Error in selected place $e");
    }
    if (!widget.create) {

      if (mm.selectedDeposit.date != null) {
        List<String> date = mm.selectedDeposit.date.toString().split("-");
        _date = DateTime(
            int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
      }

      _selectedPlace = mm.selectedDeposit.place;
      _selectedRecycleType = mm.selectedDeposit.recyclingType;

    }
  }


  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  Place? _selectedPlace;
  TextEditingController amountController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RecyclingType? _selectedRecycleType;

  final dateCtl = TextEditingController();
  Widget getRecycleTypes(){

    if (_selectedPlace == null){
      return Text("Para seleccionar un tipo de reclado debe elegir un lugar.");
    }


    return DropdownButtonFormField(
      value: _selectedRecycleType,
      hint: Text(
        'Elige un tipo de reciclado:',
      ),
      validator:(val){
        if(val == null){
          return "Debe seleccionar un tipo de reciclado.";
        }
      },
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          _selectedRecycleType = value as RecyclingType;
        });
      },
      onSaved: (value) {
        setState(() {
          _selectedRecycleType = value as RecyclingType;
        });
      },
      items: _selectedPlace!.recyclingTypes
          .map((val) {
        return DropdownMenuItem(
          value: val,
          child: Text(
            val.name,
          ),
        );
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    mm = context.watch<ModelsManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text("${(widget.create)? 'Nuevo Deposito':'Editar Deposito N°${mm.selectedDeposit.id}'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {

              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                print("intentando");
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                String formatDate(DateTime time){
                  return "${time.year}-${time.month}-${time.day}";
                }
                if (widget.create) {

                  createDeposit(Deposit(id: 0,place: _selectedPlace!,amount: amountController.text,weight: weightController.text,recyclingType: _selectedRecycleType!,date:formatDate(_date)),places:mm.places,recyclingTypes:mm.recyclingTypes).then((deposit){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deposito Creado.')),
                    );
                    Navigator.of(context).pop();
                    mm.updateAll();
                  });
                }else{
                  print("intentando");
                  mm.selectedDeposit.date = formatDate(_date);
                  mm.selectedDeposit.place = _selectedPlace!;
                  mm.selectedDeposit.recyclingType = _selectedRecycleType!;
                  mm.selectedDeposit.amount = amountController.text;
                  mm.selectedDeposit.weight = weightController.text;
                  editDeposit(mm.selectedDeposit,places: mm.places, recyclingTypes: mm.recyclingTypes).then((deposit){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deposito editado.')),
                    );
                    Navigator.of(context).pop();
                    mm.updateAll();
                  });
                }
              }
            },
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePickerFormField(
                onSaved: (value) {
                  setState(() {
                    _date = value!;
                  });
                },

                validator:(val){
                  if (val == null){
                    return "Debe ingresar una fecha.";
                  }
                  if (DateTime.now().isAfter(val)){
                    return "La fecha seleccionada debe ser futura.";
                  }

                  _date = val;


                },
                context: context,
                initialDateTime: _date,
              ),
              ListTile(
                leading: const Icon(Icons.location_pin),
                title: DropdownButtonFormField(
                  value: _selectedPlace,
                  hint: Text(
                    'Elige un lugar:',
                  ),
                  validator:(val){
                    if(val == null){
                      return "Debe seleccionar un lugar.";
                    }
                  },
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedPlace = value as Place;
                      try {
                        _selectedRecycleType = _selectedPlace!.recyclingTypes
                            .first;
                      }catch (e){
                        _selectedRecycleType = null;
                      }
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedPlace = value as Place;
                      try {
                        _selectedRecycleType = _selectedPlace!.recyclingTypes
                            .first;
                      }catch (e){
                        _selectedRecycleType = null;
                      }
                    });
                  },
                  items: mm.places
                      .map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val.name,
                      ),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                leading: const Icon(IconData(0xe900,fontFamily: 'custom')),
                title: getRecycleTypes(),
              ),
              ListTile(
                leading: const Icon(IconData(0xe902,fontFamily: 'custom')),
                title: TextFormField(
                    controller: amountController..text = '${(widget.create) ? amountController.text: (mm.selectedDeposit.amount == null) ? amountController.text: mm.selectedDeposit.amount}',
                    keyboardType: TextInputType.number,
                    validator:(val){
                      if(val != null && val != "" ) {
                        if (int.parse(val) < 1) {
                          return "La cantidad debe ser mayor o igual a 1.";
                        }
                        if (int.parse(val) > 100) {
                          return "La cantidad debe ser menor o igual a 100.";
                        }
                      }
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    decoration: InputDecoration(
                      labelText: "Cantidad(opcional): ",
                      hintText: "Cantidad",
                    )
                ),
              ),
              ListTile(
                leading: const Icon(IconData(0xe901,fontFamily: 'custom')),
                title: TextFormField(
                  validator:(val){
                    if(val != null && val != "" ) {
                      if (double.parse(val) < 1) {
                        return "El peso debe ser mayor o igual a 1.";
                      }
                      if (double.parse(val) > 100) {
                        return "El peso debe ser menor o igual a 100.";
                      }
                    }
                  },
                  controller: weightController..text = '${(widget.create) ? weightController.text: (mm.selectedDeposit.weight == null) ? weightController.text: mm.selectedDeposit.weight}',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso total(Kg, opcional): ",
                    hintText: "Peso total",
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerFormField extends FormField<DateTime> {

  DatePickerFormField({
    required FormFieldSetter<DateTime> onSaved,
    required FormFieldValidator<DateTime> validator,
    required DateTime initialDateTime,
    required BuildContext context,

  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialDateTime,
      builder: (FormFieldState<DateTime> state) {
        return ListTile(
          leading:const Icon(Icons.date_range),
          title: Text("Fecha a realizar el deposito"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${state.value!.year}-${state.value!.month}-${state.value!.day}"),
              Text("${(state.errorText == null) ?'': state.errorText}",style:TextStyle(color: Theme.of(context).errorColor)),
            ],
          ),

          onTap: () async{
            DateTime? date = DateTime(1900);
            FocusScope.of(context).requestFocus(new FocusNode());

            date = await showDatePicker(
                context: context,
                initialDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
                lastDate:  DateTime(2100)
            );
            if (date == null){
              date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
            }
            state.didChange(date);
          },
        );
      }
  );
}
