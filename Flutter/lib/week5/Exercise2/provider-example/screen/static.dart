import 'package:flutter/material.dart';

class StaticScreen extends StatelessWidget {
  const StaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Welcome to the Color Counter App!",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
