import 'package:flutter_application_1/data/sources/like_local_service.dart';

class LikeRepository {
  final LikeLocalService _localService;

  LikeRepository(this._localService);

  Future<Set<int>> getLikedPostIds() async {
    return await _localService.getLikedPostIds();
  }

  Future<void> toggleLike(int postId) async {
    final isLiked = await _localService.isLiked(postId);
    if (isLiked) {
      await _localService.unlikePost(postId);
    } else {
      await _localService.likePost(postId);
    }
  }

  Future<bool> isLiked(int postId) async {
    return await _localService.isLiked(postId);
  }
}
