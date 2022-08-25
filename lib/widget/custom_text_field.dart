import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextInputType textInputType;
  String labelText;
  TextEditingController textEditingController;
  bool secure;

  CustomTextField({
    Key? key,
    this.textInputType = TextInputType.text,
    this.secure = false,
    required this.labelText,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 5, end: 5, top: 10),
      child: TextField(
        obscureText: secure,
        keyboardType: textInputType,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black45,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black45,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
