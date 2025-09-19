import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_task/core/models/post_model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("@@@@@@@@@@%%%%%%@@@@!!!!!!!!!Fetched posts count: ${data.length}");
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
