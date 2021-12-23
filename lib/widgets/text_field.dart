import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String title;
  bool showHelper = false;
  String helperText;
  TextEditingController controller;
  AppTextField(
      {@required this.title,
      this.controller,
      this.helperText,
      this.showHelper,
      Key key})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.widget.controller ?? TextEditingController(),
      decoration: InputDecoration(
        helperText: (widget.showHelper ?? false) ? widget.helperText : "",
        helperStyle: TextStyle(
          color: Color(0xFFFF0000),
        ),
        labelText: widget.title,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF1689D8),
          ),
        ),
      ),
    );
  }
}
