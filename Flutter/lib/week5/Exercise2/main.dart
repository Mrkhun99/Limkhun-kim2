import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/week5/Exercise2/provider-example/provider/colorcounter.dart';
import 'provider-example/screen/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorCounters(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
