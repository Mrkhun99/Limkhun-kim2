import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6/EX-2-START-CODE/repository/http_posts_repository.dart';
import 'package:week6/EX-2-START-CODE/ui/providers/post_provider.dart';
import 'package:week6/EX-2-START-CODE/ui/screens/post_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider(repository: HttpPostRepository())),
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
      home: const PostScreen(),
    );
  }
}
