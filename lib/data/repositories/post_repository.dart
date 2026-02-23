import 'package:flutter_application_1/data/model/post.dart';
import 'package:flutter_application_1/data/sources/post_api_service.dart';

class PostRepository {
  final PostApiService _apiService;

  PostRepository(this._apiService);

  Future<List<Post>> fetchPosts() async {
    return await _apiService.fetchPosts();
  }
}
