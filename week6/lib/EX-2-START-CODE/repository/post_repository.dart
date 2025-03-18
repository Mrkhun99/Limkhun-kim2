import 'package:week6/EX-2-START-CODE/model/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts(); // Fetch a list of posts
}
