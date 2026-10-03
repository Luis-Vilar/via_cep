part of 'home_bloc.dart';

sealed class HomeEvent {}

final class GetAddressEvent extends HomeEvent {
  final ZipCode zip;

  new({required this.zip});
}
