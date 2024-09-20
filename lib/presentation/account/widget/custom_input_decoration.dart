import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  const CustomInputDecoration({
    super.labelText,
    super.labelStyle,
    OutlineInputBorder? super.border,
    OutlineInputBorder? super.focusedBorder,
    super.filled,
    super.fillColor,
  });
}
