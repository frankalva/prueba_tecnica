import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/presentation/cubits/post_cubit/post_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/post_cubit/post_state.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_state.dart';
import 'package:flutter_application_1/presentation/widgets/post_card_widget.dart';
import 'package:flutter_application_1/presentation/widgets/error_widget.dart';
import 'package:flutter_application_1/presentation/widgets/progress_widget.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() => _isSearching = true);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _query = value.toLowerCase().trim();
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, postState) {
          if (postState is PostLoading) {
            return const ProgressWidget();
          }

          if (postState is PostError) {
            return ErrorScreen(
              message: postState.message,
              onRetry: () => context.read<PostCubit>().fetchPosts(),
            );
          }

          if (postState is PostLoaded) {
            final filteredPosts = postState.posts
                .where((post) =>
                    post.title.toLowerCase().contains(_query) ||
                    post.body.toLowerCase().contains(_query))
                .toList();

            return Column(
              children: [
                // Barra de busqueda con debounce
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search posts...',
                      suffix: _isSearching
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                // Listado de posts o empty state
                Expanded(
                  child: filteredPosts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _query.isEmpty
                                    ? 'No posts available'
                                    : 'No results for "$_query"',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : BlocBuilder<LikeCubit, LikeState>(
                          builder: (context, likeState) {
                            return ListView.builder(
                              itemCount: filteredPosts.length,
                              itemBuilder: (context, index) {
                                final post = filteredPosts[index];
                                final isLiked = likeState is LikeLoaded &&
                                    likeState.isLiked(post.id);

                                return PostCardWidget(
                                  post: post,
                                  isLiked: isLiked,
                                  onTap: () => context.push(
                                    '/post/${post.id}',
                                    extra: post,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
