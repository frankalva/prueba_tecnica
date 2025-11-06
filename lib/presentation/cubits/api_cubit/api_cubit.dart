import 'package:flutter_application_1/data/sources/api_service.dart';
import 'package:flutter_application_1/presentation/cubits/api_cubit/api_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiCubit extends Cubit<ApiState> {

  final ApiService repository;

  ApiCubit(this.repository) : super(ApiInitial());

  Future<void> fetchItems() async {
    emit(ApiLoading());
    try {
      final items = await repository.fetchItems();
      emit(ApiLoaded(items));
    } catch (e) {
      emit(ApiError("Failed to load items: ${e.toString()}"));
    }
  }
}
