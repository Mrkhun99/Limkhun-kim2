import 'package:flutter/material.dart';
import 'counter.dart';
import 'static.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Color Counter App")),
      body: Column(
        children: [
          StaticScreen(), 
          CounterScreen(), ],
      ),
    );
  }
}
