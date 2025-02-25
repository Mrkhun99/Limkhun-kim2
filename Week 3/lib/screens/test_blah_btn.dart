import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';

class BlaButtonTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlaButton Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              text: "Button with Icon",
              icon: Icons.star,
              onPressed: () => print("Icon Button Clicked"),
            ),
            SizedBox(height: 10),
            BlaButton(
              text: "Disabled Button",
              onPressed: null, // Disabled state
            ),
          ],
        ),
      ),
    );
  }
}
