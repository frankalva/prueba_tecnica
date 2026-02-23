import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/repositories/like_repository.dart';
import 'package:flutter_application_1/data/sources/like_local_service.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_cubit.dart';
import 'package:flutter_application_1/presentation/cubits/like_cubit/like_state.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  LikeCubit createCubit() =>
      LikeCubit(LikeRepository(LikeLocalService()));

  group('LikeCubit', () {
    test('estado inicial es LikeInitial', () {
      final cubit = createCubit();
      expect(cubit.state, isA<LikeInitial>());
      cubit.close();
    });

    blocTest<LikeCubit, LikeState>(
      'loadLikes emite LikeLoaded vacío',
      build: createCubit,
      act: (cubit) => cubit.loadLikes(),
      expect: () => [
        isA<LikeLoaded>().having((s) => s.likedPostIds, 'ids', isEmpty),
      ],
    );

    blocTest<LikeCubit, LikeState>(
      'toggleLike agrega y luego remueve el like',
      build: createCubit,
      act: (cubit) async {
        await cubit.loadLikes();
        await cubit.toggleLike(1);
      },
      expect: () => [
        isA<LikeLoaded>().having((s) => s.likedPostIds, 'ids', isEmpty),
        isA<LikeLoaded>().having((s) => s.likedPostIds, 'ids', contains(1)),
      ],
    );
  });
}
