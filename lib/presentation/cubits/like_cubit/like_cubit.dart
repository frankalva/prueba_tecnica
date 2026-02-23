import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/repositories/like_repository.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final LikeRepository _repository;

  LikeCubit(this._repository) : super(LikeInitial());

  /// Carga los IDs de posts con like desde la persistencia local.
  Future<void> loadLikes() async {
    final likedIds = await _repository.getLikedPostIds();
    emit(LikeLoaded(likedIds));
  }

  /// Alterna el like de un post y actualiza el estado.
  Future<void> toggleLike(int postId) async {
    await _repository.toggleLike(postId);
    await loadLikes();
  }
}
