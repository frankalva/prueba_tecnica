import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/repositories/like_repository.dart';
import 'package:flutter_application_1/data/sources/like_local_service.dart';

void main() {
  late LikeRepository repository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = LikeRepository(LikeLocalService());
  });

  group('LikeRepository', () {
    test('toggleLike da like si no tenia', () async {
      await repository.toggleLike(1);
      expect(await repository.isLiked(1), isTrue);
    });

    test('toggleLike quita like si ya tenia', () async {
      await repository.toggleLike(1);
      await repository.toggleLike(1);
      expect(await repository.isLiked(1), isFalse);
    });
  });
}
