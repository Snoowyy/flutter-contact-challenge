import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController _controller;
  final TextStyle _style;
  final String _placeholder;
  final bool _security;
  const InputWidget(this._placeholder, this._controller, this._style, this._security,
      {super.key});

  String? get _errorText {
    final text = _controller.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }
  @override
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _security,
      controller: _controller,
      style: _style,
      decoration: InputDecoration(
          fillColor: Colors.blue[50],
          filled: true,
          hintText: _placeholder,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 129, 197, 252), fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
