import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/model/preference_model.dart';

abstract class PrefsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrefsInitial extends PrefsState {}

class PrefsLoading extends PrefsState {}

class PrefsLoaded extends PrefsState {
  final List<Preference> preferences;

  PrefsLoaded(this.preferences);

  @override
  List<Object?> get props => [preferences];
}

class PrefsError extends PrefsState {
  final String message;

  PrefsError(this.message);

  @override
  List<Object?> get props => [message];
}
