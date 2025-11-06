import 'package:flutter_application_1/data/model/item.dart';
import 'package:flutter_application_1/data/sources/api_service.dart';

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<List<Item>> fetchItems() async {
    return await apiService.fetchItems();
  }
}
