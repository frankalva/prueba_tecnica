import 'package:hive/hive.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';

class HiveService {
  static const String preferenceBoxName = 'db_preferences';

  Future<void> init() async {
    Hive.registerAdapter(PreferenceAdapter());
    await Hive.openBox<Preference>(preferenceBoxName);
  }

  Box<Preference> get _preferenceBox => Hive.box<Preference>(preferenceBoxName);

  Future<List<Preference>> getAll() async {
    return _preferenceBox.values.toList();
  }

  Future<void> add(Preference pref) async {
    await _preferenceBox.add(pref);
  }

  Future<void> delete(int index) async {
    await _preferenceBox.deleteAt(index);
  }

  Future<void> update(int index, Preference pref) async {
    await _preferenceBox.putAt(index, pref);
  }

  Future<void> clear() async {
    await _preferenceBox.clear();
  }

  Future<Preference?> getAt(int index) async {
    return _preferenceBox.getAt(index);
  } 

  
}
