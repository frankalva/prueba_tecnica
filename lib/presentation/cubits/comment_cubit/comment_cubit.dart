import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/repositories/comment_repository.dart';
import 'package:flutter_application_1/presentation/cubits/comment_cubit/comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepository _repository;

  CommentCubit(this._repository) : super(CommentInitial());

  Future<void> fetchComments(int postId) async {
    emit(CommentLoading());
    try {
      final comments = await _repository.fetchComments(postId);
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError('Failed to load comments: ${e.toString()}'));
    }
  }
}
