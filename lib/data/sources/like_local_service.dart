import 'package:shared_preferences/shared_preferences.dart';

class LikeLocalService {
  static const String _likedPostsKey = 'liked_posts';

  Future<Set<int>> getLikedPostIds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = prefs.getStringList(_likedPostsKey) ?? [];
    return ids.map((id) => int.parse(id)).toSet();
  }

  Future<void> likePost(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = prefs.getStringList(_likedPostsKey) ?? [];
    final set = ids.toSet();
    set.add(postId.toString());
    await prefs.setStringList(_likedPostsKey, set.toList());
  }

  Future<void> unlikePost(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = prefs.getStringList(_likedPostsKey) ?? [];
    final set = ids.toSet();
    set.remove(postId.toString());
    await prefs.setStringList(_likedPostsKey, set.toList());
  }

  Future<bool> isLiked(int postId) async {
    final liked = await getLikedPostIds();
    return liked.contains(postId);
  }
}
