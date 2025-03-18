import 'package:flutter/material.dart';
import '../models/course.dart';

class CoursesProvider extends ChangeNotifier {
  final List<Course> _courses = [Course(name: 'HTML'), Course(name: 'JAVA')];

  List<Course> get courses => _courses;

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }
}
