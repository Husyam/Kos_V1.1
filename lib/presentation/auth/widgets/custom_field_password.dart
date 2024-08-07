import 'package:flutter/material.dart';

import '../../home/widgets/theme.dart';

class PasswordField extends StatefulWidget {
  PasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: blackColor,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Password",
        filled: true,
        fillColor: whiteColor,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        suffixIcon: GestureDetector(
          onTap: _toggleObscured,
          child: Icon(
            _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            size: 24,
          ),
        ),
      ),
    );
  }
}
