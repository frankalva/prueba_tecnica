import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/api_constant.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/data/model/post.dart';

class PostApiService {
  final Dio _dio;

  PostApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: ConstansApi.baseUrl,
              headers: {
                'Accept': 'application/json',
                'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36',
              },
            ));

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get(
        ConstansApi.postsEndpoint,
        options: Options(
          receiveTimeout: ConstansApi.timeout,
          sendTimeout: ConstansApi.timeout,
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load posts: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw UnknownException('Unknown error while fetching posts');
    }
  }
}
