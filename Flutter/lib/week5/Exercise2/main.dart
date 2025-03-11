import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider-example/provider/count_notifier.dart';
import 'provider-example/screen/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: MyWidget()),
      ),
    ),
  );
}
