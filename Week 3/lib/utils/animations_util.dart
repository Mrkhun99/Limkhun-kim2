import 'package:flutter/material.dart';

class AnimationsUtil {
  static Route<T> createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0); // Start from bottom
    const end = Offset(0.0, 0.0);   // Move to original position
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
