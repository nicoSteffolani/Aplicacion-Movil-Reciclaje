import 'package:flutter/material.dart';


class BotonCircular extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const BotonCircular({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            color: color,
            textColor: textColor,
            onPressed: press,
            child: Text(text, style: TextStyle(fontSize: 18),)
        ),
      ),
    );
  }
}