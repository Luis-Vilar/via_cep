part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final Address address;

  new({required this.address});
}

final class HomeError extends HomeState {
  final String message;

  new({required this.message});
}
