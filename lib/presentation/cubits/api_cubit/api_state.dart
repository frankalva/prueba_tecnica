import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/model/item.dart';

abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final List<Item> items;
  ApiLoaded(this.items);
}

class ApiError extends ApiState {
  final String message;
  ApiError(this.message);
}
