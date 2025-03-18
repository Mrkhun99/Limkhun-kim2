import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6/EX-1-START-CODE/provider/course_provider.dart';
import 'package:week6/EX-1-START-CODE/screens/course_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course App',
      home: CourseListScreen(),
    );
  }
}
