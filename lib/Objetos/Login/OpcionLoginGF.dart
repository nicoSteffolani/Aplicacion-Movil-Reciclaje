import 'package:ecoinclution_proyect/Constants.dart';
import 'package:flutter/material.dart';

class LoginGF extends StatelessWidget {

  const LoginGF({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Divider(
          color: kColorVerde,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 40),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: kBlanco,
                ),
                backgroundColor: kBlanco,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              ),
              onPressed: () {},
              child: Image(
                image: AssetImage("assets/images/ISconGoogle.png"),
                alignment: Alignment.center,
                height: 35,
              ),
            ),
          ),
        ),
        Container(
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: kBlanco,
                ),
                backgroundColor: kBlanco,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              ),
              onPressed: () {},
              child: Image(
                image: AssetImage("assets/images/ISconFacebook.png"),
                alignment: Alignment.center,
                height: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}