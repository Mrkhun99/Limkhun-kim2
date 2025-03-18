class Post {
  final int id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json['id'] is! int || json['title'] is! String || json['body'] is! String) {
      throw Exception("Invalid JSON data");
    }
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'], // API uses 'body' instead of 'description'
    );
  }
}
