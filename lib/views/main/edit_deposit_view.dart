import 'package:ecoinclution_proyect/api_connection/apis.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class EditDepositPage extends StatefulWidget {
  final Deposit? deposit;
  final bool create;

  const EditDepositPage({Key? key,
    required this.create,this.deposit,
  }): super(key: key);

  @override
  _EditDepositPageState createState() => _EditDepositPageState();
}
class _EditDepositPageState extends State<EditDepositPage> {

  @override
  initState() {
    if (this.widget.deposit != null){
      if (this.widget.deposit!.date != null){
        List<String> date = this.widget.deposit!.date.toString().split("-");
        _date = DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
      }

      _selectedPlace = this.widget.deposit!.place;
      _selectedRecycleType = this.widget.deposit!.recycleType;

    }
    super.initState();
  }


  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  Object? _selectedPlace;
  TextEditingController amountController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Object? _selectedRecycleType;
  List<RecycleType> _listOfTypes = [];
  List<Place> _listOfPlaces = [];

  final dateCtl = TextEditingController();
  Widget getRecycleTypes(){

    if (_selectedPlace == null){
      return Text("Para seleccionar un tipo de reclado debe elegir un lugar.");
    }
    Place? place;
    g.models.points.forEach((element){
      if (element.id == _selectedPlace){
        place = Place(id: element.id, name: element.name,lat: element.lat,lng: element.lng,recycleType:element.recycleType);
      }
    });
    if (place == null){
      g.models.centers.forEach((element){
        if (element.id == _selectedPlace){
          place = Place(id: element.id, name: element.name,lat: element.lat,lng: element.lng,recycleType:element.recycleType);
        }
      });
    }
    _listOfTypes = [];
    place!.recycleType.forEach((element){
      g.models.types.forEach((type){
        if (type.id == element){
          _listOfTypes.add(type);
        }
      });
    });

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
          _selectedRecycleType = value;
        });
      },
      onSaved: (value) {
        setState(() {
          _selectedRecycleType = value;
        });
      },
      items: _listOfTypes
          .map((val) {
        return DropdownMenuItem(
          value: val.id,
          child: Text(
            val.name,
          ),
        );
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    _listOfPlaces = [];
    List<dynamic> centerList = g.models.centers ;
    List<dynamic> pointList = g.models.points ;
    centerList.forEach((place){
      _listOfPlaces.add(Place(id: place.id, name: place.name,lat: place.lat,lng: place.lng,recycleType:place.recycleType));
    });
    pointList.forEach((place){
      _listOfPlaces.add(Place(id: place.id, name: place.name,lat: place.lat,lng: place.lng,recycleType:place.recycleType));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("${(widget.create)? 'Nuevo Deposito':'Editar Deposito N°${widget.deposit!.id}'}"),
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

                  createDeposit(Deposit(id: 0,place: _selectedPlace,amount: amountController.text,weight: weightController.text,recycleType: _selectedRecycleType,date:formatDate(_date))).then((deposit){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deposito Creado.')),
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/deposits', (Route<dynamic> route) => false);
                  });
                }else{
                  print("intentando");
                  widget.deposit!.date = formatDate(_date);
                  widget.deposit!.place = _selectedPlace;
                  widget.deposit!.place = _selectedRecycleType;
                  widget.deposit!.amount = amountController.text;
                  widget.deposit!.weight = weightController.text;
                  editDeposit(widget.deposit!).then((deposit){

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deposito editado.')),
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/deposits', (Route<dynamic> route) => false);
                  });
                }
              }
            },
          ),
        ],

      ),
      body: Center(
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
                      _selectedPlace = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedPlace = value;
                    });
                  },
                  items: _listOfPlaces
                      .map((val) {
                    return DropdownMenuItem(
                      value: val.id,
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
                    controller: amountController..text = '${(widget.deposit == null) ? amountController.text: (widget.deposit!.amount == null) ? amountController.text: widget.deposit!.amount}',
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
                  controller: weightController..text = '${(widget.deposit == null) ? weightController.text: (widget.deposit!.weight == null) ? weightController.text: widget.deposit!.weight}',
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
