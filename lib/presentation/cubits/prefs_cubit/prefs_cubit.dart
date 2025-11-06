import 'package:flutter_application_1/presentation/cubits/prefs_cubit/prefs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/data/sources/hive_service.dart';

class PrefsCubit extends Cubit<PrefsState> {
  final HiveService repository;

  PrefsCubit(this.repository) : super(PrefsInitial());

  Future<void> loadPreferences() async {
    emit(PrefsLoading());
    try {
      final preferences = await repository.getAll();
      emit(PrefsLoaded(preferences));
    } catch (e) {
      emit(PrefsError("Failed to load preferences: ${e.toString()}"));
    }
  }

  Future<void> addPreference(preference) async {
    try {
      await repository.add(preference);
      await loadPreferences();
    } catch (e) {
      emit(PrefsError("Failed to add preference: ${e.toString()}"));
    }
  }

  Future<void> deletePreference(int index) async {
    try {
      await repository.delete(index);
      await loadPreferences();
    } catch (e) {
      emit(PrefsError("Failed to delete preference: ${e.toString()}"));
    }
  }
}
