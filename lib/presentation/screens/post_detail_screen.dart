import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/model/post.dart';
import 'package:flutter_application_1/data/repositories/comment_repository.dart';
import 'package:flutter_application_1/data/sources/comment_native_service.dart';
import 'package:flutter_application_1/presentation/cubits/comment_cubit/comment_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/comment_cubit/comment_state.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_state.dart';
import 'package:flutter_application_1/presentation/widgets/comment_tile_widget.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentCubit(
        CommentRepository(CommentNativeService()),
      )..fetchComments(post.id),
      child: _PostDetailContent(post: post),
    );
  }
}

class _PostDetailContent extends StatelessWidget {
  final Post post;

  const _PostDetailContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${post.id}'),
        actions: [
          // Boton de like en el AppBar
          BlocBuilder<LikeCubit, LikeState>(
            builder: (context, likeState) {
              final isLiked =
                  likeState is LikeLoaded && likeState.isLiked(post.id);
              return IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () => context.read<LikeCubit>().toggleLike(post.id),
                tooltip: isLiked ? 'Remove from favorites' : 'Add to favorites',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seccion de informacion del post
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By user #${post.userId}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post.body,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Titulo de la seccion de comentarios
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.comment, size: 20, color: Colors.grey.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            // Listado de comentarios con manejo de estados
            BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state is CommentLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is CommentError) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => context
                              .read<CommentCubit>()
                              .fetchComments(post.id),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CommentLoaded) {
                  if (state.comments.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No comments yet',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return CommentTileWidget(comment: state.comments[index]);
                    },
                  );
                }

                return const SizedBox();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
