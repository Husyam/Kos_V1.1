import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    String? labelText,
    TextStyle? labelStyle,
    OutlineInputBorder? border,
    OutlineInputBorder? focusedBorder,
    bool? filled,
    Color? fillColor,
  }) : super(
          labelText: labelText,
          labelStyle: labelStyle,
          border: border,
          focusedBorder: focusedBorder,
          filled: filled,
          fillColor: fillColor,
        );
}
