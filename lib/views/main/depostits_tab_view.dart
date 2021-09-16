import 'package:flutter/material.dart';

class DepositsPage extends StatelessWidget {
  const DepositsPage({Key? key}) : super(key: key);

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
