import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.black38;
  Color lightColor = Colors.white70;
  Color orentPastel = Color(0xff8a80);

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.black38,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitle1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.deepOrange[200],
          fontWeight: FontWeight.bold,
        ),
      );

  Container showLogo() {
    return Container(
      width: 300.0,
      child: Image.asset('images/Logo.png'),
    );
  }

  Container showLogo1() {
    return Container(
      width: 250.0,
      child: Image.asset('images/Logo7.png'),
    );
  }

  Container showLogo2() {
    return Container(
      width: 200.0,
      child: Image.asset('images/Logo3.png'),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  MyStyle();
}