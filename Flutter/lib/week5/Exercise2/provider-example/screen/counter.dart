import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/week5/Exercise2/provider-example/provider/colorcounter.dart';
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorCounters>(
      builder: (context, colorCounters, child) {
        return Column(
          children: [
            Text("Red: ${colorCounters.redCount}", style: TextStyle(color: Colors.red, fontSize: 50)),
            Text("Blue: ${colorCounters.blueCount}", style: TextStyle(color: Colors.blue, fontSize: 50)),
            ElevatedButton(
              onPressed: () => colorCounters.incrementRed(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Add Red "),
            ),
            ElevatedButton(
              onPressed: () => colorCounters.incrementBlue(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Add Blue"),
            ),
          ],
        );
      },
    );
  }
}
