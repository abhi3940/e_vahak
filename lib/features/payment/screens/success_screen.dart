import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Confirm",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
