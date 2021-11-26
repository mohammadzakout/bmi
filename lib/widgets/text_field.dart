import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String title;

  const AppTextField({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: title,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF1689D8),
          ),
        ),
      ),
    );
  }
}
