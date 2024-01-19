import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomTextFeilds extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextFeilds({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  style: Theme.of(context)
                          .textTheme
                          .titleSmall,
                  decoration: InputDecoration(
                    hintText: hint,
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