import 'package:equatable/equatable.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object?> get props => [];
}

class LikeInitial extends LikeState {}

class LikeLoaded extends LikeState {
  final Set<int> likedPostIds;

  const LikeLoaded(this.likedPostIds);

  bool isLiked(int postId) => likedPostIds.contains(postId);

  @override
  List<Object?> get props => [likedPostIds];
}
