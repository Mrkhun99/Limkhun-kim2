import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1 - Get the post provider
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            // 2 - Fetch the list of posts
            onPressed: postProvider.fetchPosts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      // 3 - Display the posts
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider provider) {
    final postValue = provider.postValue;

    if (postValue == null) {
      return const Text('Tap refresh to display posts'); // Display an empty state
    }

    switch (postValue.state) {
      case AsyncValueState.loading:
        return const CircularProgressIndicator(); // Display a loading state

      case AsyncValueState.error:
        return Text('Error: ${postValue.error}'); // Display an error message

      case AsyncValueState.success:
        final posts = postValue.data!;
        if (posts.isEmpty) {
          return const Text("No posts for now"); // Display empty list message
        }
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: posts[index]);
          },
        ); // Display the list of posts
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
    );
  }
}
