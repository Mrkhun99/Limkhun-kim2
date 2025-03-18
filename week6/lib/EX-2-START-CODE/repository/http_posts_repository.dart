import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostRepository implements PostRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";


  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch posts");
    }
  }
}
