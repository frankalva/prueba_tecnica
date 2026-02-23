import 'package:flutter_application_1/data/model/item.dart';
import 'package:flutter_application_1/data/model/post.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';
import 'package:flutter_application_1/presentation/screens/post_list_screen.dart';
import 'package:flutter_application_1/presentation/screens/post_detail_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/posts',
  routes: [
    GoRoute(
      path: '/posts',
      name: 'posts',
      builder: (context, state) => const PostListScreen(),
    ),
    GoRoute(
      path: '/post/:id',
      name: 'post-detail',
      builder: (context, state) {
        final post = state.extra as Post;
        return PostDetailScreen(post: post);
      },
    ),
  ],
);
