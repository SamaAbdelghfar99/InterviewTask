import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:interview_task/core/models/post_model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network settings.');
    } on HttpException {
      throw Exception('Could not reach the server. Please try again later.');
    } on FormatException {
      throw Exception('Invalid response format. Please try again.');
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}