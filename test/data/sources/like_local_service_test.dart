import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/data/sources/like_local_service.dart';

void main() {
  late LikeLocalService service;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    service = LikeLocalService();
  });

  group('LikeLocalService', () {
    test('retorna vacío cuando no hay likes', () async {
      final result = await service.getLikedPostIds();
      expect(result, isEmpty);
    });

    test('likePost guarda el ID y unlikePost lo remueve', () async {
      await service.likePost(1);
      expect(await service.isLiked(1), isTrue);

      await service.unlikePost(1);
      expect(await service.isLiked(1), isFalse);
    });

    test('isLiked retorna false si el post no tiene like', () async {
      expect(await service.isLiked(99), isFalse);
    });
  });
}
