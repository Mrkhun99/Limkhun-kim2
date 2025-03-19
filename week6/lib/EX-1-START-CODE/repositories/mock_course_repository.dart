import 'package:week6/EX-1-START-CODE/repositories/course_repository.dart';
import '../models/course.dart';

class CoursesMockRepository implements CoursesRepository {
  final List<Course> _courses = [
    Course(name: "HTML"),
    Course(name: "Java"),
    Course(name: "Flutter"),
  ];

  @override
  List<Course> getCourses() {
    return _courses;
  }

  @override
  Course getCourseFor(String courseId) {
    return _courses.firstWhere((course) => course.name == courseId);
  }

  @override
  void addScore(String courseId, CourseScore score) {
    final course = getCourseFor(courseId);
    course.addScore(score);
  }
}
