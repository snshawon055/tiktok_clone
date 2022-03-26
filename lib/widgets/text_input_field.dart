import 'package:flutter/material.dart';
import 'package:tiktok_clone/color/colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPass;
  final TextInputType textInputType;
  const TextInputField(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.labelText,
      this.isPass = false,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: 15,
        ),
        label: Text(labelText),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey,
            )),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: borderColors)),
      ),
      obscureText: isPass,
      keyboardType: textInputType,
    );
  }
}
