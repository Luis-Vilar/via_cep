part of 'map_bloc.dart';

sealed class MapEvent {}

final class GetCoordinates extends MapEvent {
  GetCoordinates({required this.zipCode});
  String zipCode;
}
