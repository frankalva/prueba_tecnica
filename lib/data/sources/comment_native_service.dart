import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/data/model/comment.dart';

class CommentNativeService {
  static const _channel = MethodChannel(
    'com.example.flutter_application_1/comments',
  );

  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final result = await _channel.invokeMethod('getComments', {
        'postId': postId,
      });

      if (result == null) {
        throw ApiException('No data received from native platform');
      }

      final List<dynamic> data = List<dynamic>.from(result);
      return data.map((json) {
        final map = Map<String, dynamic>.from(json);
        return Comment.fromJson(map);
      }).toList();
    } on PlatformException catch (e) {
      throw ApiException('Native platform error: ${e.message}');
    } on MissingPluginException {
      throw ApiException(
        'Platform channel not available. '
        'Comments must be fetched from native iOS/Android.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw UnknownException('Unknown error fetching comments');
    }
  }
}
