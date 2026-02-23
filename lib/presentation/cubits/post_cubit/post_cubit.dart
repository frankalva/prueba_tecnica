import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/data/repositories/post_repository.dart';
import 'package:flutter_application_1/presentation/cubits/post_cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _repository;

  PostCubit(this._repository) : super(PostInitial());

  /// Carga la lista de posts desde la API.
  Future<void> fetchPosts() async {
    emit(PostLoading());
    try {
      final posts = await _repository.fetchPosts();
      emit(PostLoaded(posts));
    } on ApiException catch (e) {
      emit(PostError(e.message));
    } on UnknownException catch (e) {
      emit(PostError(e.message));
    } catch (e) {
      emit(PostError('Failed to load posts: $e'));
    }
  }
}
