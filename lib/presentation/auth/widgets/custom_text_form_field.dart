import 'package:flutter/material.dart';

import '../../home/widgets/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = '',
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            cursorColor: blackColor,
            obscureText: obscureText,
            controller: controller,
            //jika type text makan akan menampilkan keyboard biasa jika type number akan menampilkan keyboard number
            keyboardType: keyboardType == 'number'
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
