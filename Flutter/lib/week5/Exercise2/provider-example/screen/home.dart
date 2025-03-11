import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/week5/Exercise2/provider-example/provider/count_notifier.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (BuildContext context, counter, Widget? child) {
        return Column(
          children: [
            Text("Count =  ${counter.count}"),
            ElevatedButton(
              onPressed: () => {counter.increment()},
              child: Text("ADD 1"),
            ),
          ],
        );
      },
    );
  }
}
