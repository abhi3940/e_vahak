import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTapBtn; // Modify this line

  PrimaryButton({Key? key, required this.title, this.onTapBtn})
      : super(key: key); // Modify this line

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(top: 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
          onPressed:  onTapBtn, // Modify this line
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }
}
