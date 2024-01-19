import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  const PasswordField({Key? key, required this.hint, required this.controller}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller,
        style: Theme.of(context)
                            .textTheme
                            .titleSmall,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _toggle,
          ),
          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color:
                                Colors.green), // Change the border color to green
                      ),
                      filled: true,
                      fillColor: Pallete.grey,
        ),
      ),
    );
  }
}