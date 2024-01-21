import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Done', style: TextStyle(fontSize: 24,color: Colors.black)),
      ),
    );
  }
}