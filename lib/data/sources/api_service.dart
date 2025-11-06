import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/api_constant.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/data/model/item.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ConstansApi.baseUrl));

  Future<List<Item>> fetchItems() async {
    try {
      final response = await _dio.get(
        ConstansApi.photosEndpoint,
        options: Options(
          receiveTimeout: ConstansApi.timeout,
          sendTimeout: ConstansApi.timeout,
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load items: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ApiException('Error from the red: ${e.message}');
    } catch (e, stacktrace) {
      throw UnknownException('Error desconocido', stacktrace);
    }
  }
}
