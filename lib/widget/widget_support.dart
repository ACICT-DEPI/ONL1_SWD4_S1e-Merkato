import 'package:flutter/material.dart';

// header
class Appwidget {
  static TextStyle boldTextFeildStyle() {
    return TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        );
  }

// head line font style
  static TextStyle HeadLinetextFeildStyle() {
    return TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        
        );
  }

  // light text style
  static TextStyle LiighttextFeildStyle() {
    return TextStyle(
        color: Colors.black38,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        );
  }
  static TextStyle SimitextFeildStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        );
  }
}
