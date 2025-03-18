import '../model/post.dart';
import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(Duration(seconds: 5)); // Simulating network delay
    return [
      Post(id: 1, title: 'First Post', description: 'This is the first post'),
      Post(id: 2, title: 'Second Post', description: 'This is the second post'),
      Post(id: 3, title: 'Third Post', description: 'This is the third post'),
    ];
  }
}
