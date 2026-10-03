part of 'map_bloc.dart';

sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapSuccess extends MapState {
  MapSuccess({required this.coordinates});
  Coordinates coordinates;
}

final class MapError extends MapState {
  MapError({required this.message});
  String message;
}
