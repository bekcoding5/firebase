import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatefulWidget {
  String? label;
  TextEditingController controller;
  Function(String)? onChanged;

  MyTextfield({
    required this.controller,
    this.label,
    this.onChanged,
    super.key,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: TextField(
        style: TextStyle(color: Colors.amber),
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: widget.label ?? 'Email',
          hintStyle: TextStyle(fontSize: 14, color: Colors.amber),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
