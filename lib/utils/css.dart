import 'package:flutter/material.dart';

class FontStyles {
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Montserrat', // Font chữ cho tiêu đề
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle contentStyle = TextStyle(
    fontFamily: 'Lato', // Font chữ cho nội dung
    fontSize: 18.0,
    color: Colors.grey,
  );
   static const Color primaryColor = Colors.orangeAccent; // Màu cam cho header
  static const Color textColor = Colors.black87; // Màu chữ chính
}
