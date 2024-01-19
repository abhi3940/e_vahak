import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function(BuildContext) onTapBtn; // Modify this line

  const PrimaryButton({Key? key, required this.title, required this.onTapBtn}) : super(key: key); // Modify this line

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Pallete.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          onPressed: () => onTapBtn(context), // Modify this line
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
    );
    
  }
}