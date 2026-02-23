import 'package:flutter_application_1/data/model/comment.dart';
import 'package:flutter_application_1/data/sources/comment_native_service.dart';

class CommentRepository {
  final CommentNativeService _nativeService;

  CommentRepository(this._nativeService);

  Future<List<Comment>> fetchComments(int postId) async {
    return await _nativeService.fetchComments(postId);
  }
}
