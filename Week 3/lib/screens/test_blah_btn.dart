import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blah_btn.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BlaButton Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              label: "Primary Button",
              onPressed: () => print("Primary Button Pressed"),
            ),
            const SizedBox(height: 12),
            BlaButton(
              label: "Secondary Button",
              type: BlaButtonType.secondary,
              onPressed: () => print("Secondary Button Pressed"),
            ),
            const SizedBox(height: 12),
            BlaButton(
              label: "Button with Icon",
              icon: Icons.check,
              onPressed: () => print("Button with Icon Pressed"),
            ),
          ],
        ),
      ),
    );
  }
}
