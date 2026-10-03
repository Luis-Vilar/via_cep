part of 'home_bloc.dart';

sealed class HomeEvent {}

final class GetAddressEvent extends HomeEvent {
  final String zipCode;

  new({required this.zipCode});
}
