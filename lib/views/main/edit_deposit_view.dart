import 'package:ecoinclution_proyect/api_connection/apis.dart';
import 'package:ecoinclution_proyect/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ecoinclution_proyect/global.dart' as g;
import 'amount_delete_view.dart';
import 'edit_amount_view.dart';



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
        _date = DateTime.parse(this.widget.deposit!.date);
      }
      _selectedCenter = this.widget.deposit!.center;
      _selectedPoint = this.widget.deposit!.point;
    }
    super.initState();
  }


  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  Object? _selectedCenter;
  List<CenterModel> _listOfCenters = g.models.centers;
  Object? _selectedPoint;
  List<Point> _listOfPoints = [];
  List<AmountRecycle> listOfAmounts = [];

  final dateCtl = TextEditingController();

  Widget get _listView {
    List<RecycleType> list = g.models.types;
    if (_selectedCenter != null){
      if (_listOfPoints.length != 0){
        if (_selectedPoint != null) {
          if (listOfAmounts.length == 0) {
            Point selectedPointO = _listOfPoints[0];
            _listOfPoints.forEach((element) {
              if (_selectedPoint == element.id) {
                selectedPointO = element;
              }
            });
            selectedPointO.recycleType.forEach((element) {
              bool inserted = false;
              list.forEach((type) {
                if (type.id == element && !inserted) {
                  listOfAmounts.add(
                      AmountRecycle(amount: 1, weight: 0, recycleType: type.id));
                  inserted = true;
                }
              });
            });
          }
        }
      }else{
        if (listOfAmounts.length == 0) {
          list.forEach((type) {
            listOfAmounts.add(
                AmountRecycle(amount: 1, weight: 0, recycleType: type.id));
          });
        }
      }
    }
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      separatorBuilder: (_,__) => Divider(),
      itemBuilder: (_,index) {
        return Dismissible(
          key: ValueKey(listOfAmounts[index].recycleType),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            listOfAmounts.removeAt(index);
          },
          confirmDismiss: (direction) async {
            final result = await showDialog(context: context,builder: (_) => DeleteAmount());
            return result;
          },
          background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(child:const Icon(Icons.delete),alignment: Alignment.centerLeft,)
          ),
          child: ListTile(
              title: Text(
                  'Tipo de reciclado: ${list[index].name}'
              ),
              subtitle: Text("Cantidad: ${listOfAmounts[index].amount}, peso total ${listOfAmounts[index].weight}Kg"),
              trailing: const Icon(Icons.edit),
              onTap: () {
                showDialog(context: context,builder: (_) => EditAmount(create: false,amount:listOfAmounts[index])).then((value){
                  setState(() {
                    listOfAmounts[index] = value;
                  });
                });
              }
          ),
        );
      },
      itemCount: listOfAmounts.length,
    );
  }
  Widget get _dropDownPoints {
    if (_selectedCenter == null){
      _selectedPoint = null;
      return Text(
        'Para elegir un punto de acopio primero debes elegir un centro.',
        style: Theme.of(context).textTheme.bodyText1,
      );
    }
    _listOfPoints = [];
    g.models.points.forEach((element) {
      if (element.center == _selectedCenter!) {
        _listOfPoints.add(element);
      }
    });
    if (_listOfPoints.length == 0){
      return Text(
        'Este centro no tiene puntos de acopio.',
        style: Theme.of(context).textTheme.bodyText1,
      );
    }
    return DropdownButtonFormField(
      value: _selectedPoint,
      hint: Text(
        'Elige un punto:',
      ),
      isExpanded: true,
      onChanged: (value) {
        setState(() {
          listOfAmounts = [];
          _selectedPoint = value;
        });
      },
      onSaved: (value) {
        setState(() {
          listOfAmounts = [];
          _selectedPoint = value;
        });
      },

      items: _listOfPoints
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
    return Scaffold(
      appBar: AppBar(
        title: Text("${(widget.create)? 'Nuevo Deposito':'Deposito N°${widget.deposit!.id}'}"),
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
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                Object center = _selectedCenter!;
                Object point = _selectedPoint!;
                String formatDate(DateTime time){
                  return '${time.year}-${time.month}-${time.day}';
                }
                if (widget.create) {
                  createDeposit(Deposit(id: 0,center: center,date:formatDate(_date),point: point)).then((deposit){
                    listOfAmounts.forEach((element) async {
                      element.deposit = deposit.id;
                      await createAmount(element);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deposito Creado.')),
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/deposits', (Route<dynamic> route) => false);
                  });
                }else{
                  widget.deposit!.date = formatDate(_date);
                  widget.deposit!.center = center;
                  widget.deposit!.point = point;
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
                },
                context: context,
                initialDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
              ),
              ListTile(
                leading: const Icon(Icons.house),
                title: DropdownButtonFormField(
                  value: _selectedCenter,
                  hint: Text(
                    'Elige una cooperativa:',
                  ),
                  validator:(val){
                    if(val == null){
                      return "Debe seleccionar una cooperativa.";
                    }
                  },
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      listOfAmounts = [];
                      _selectedCenter = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      listOfAmounts = [];
                      _selectedCenter = value;
                    });
                  },
                  items: _listOfCenters
                      .map((val) {
                    return DropdownMenuItem(
                      value: val.id,
                      child: Text(
                        val.nombre,
                      ),
                    );
                  }).toList(),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.location_pin),
                title: _dropDownPoints,
              ),
              Divider(thickness: 2,),
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text("Edite los tipos de recilado."),
              ),
              Expanded(child:_listView),
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
          subtitle: Text("${state.value!.year}-${state.value!.month}-${state.value!.day}"),
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
