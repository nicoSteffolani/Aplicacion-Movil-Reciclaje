import 'package:flutter/material.dart';

class PaginaDepositos extends StatelessWidget {
  const PaginaDepositos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Depositos",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
