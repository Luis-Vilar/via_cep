import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/domain/entities/coordinates.dart';
import 'package:via_cep/app/domain/use_cases/get_coordinates_by_cep.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final _getCoordinates = GetCoordinatesByCep();
  MapBloc() : super(MapInitial()) {
    on<GetCoordinates>((event, emit) async {
      emit(MapLoading());
      final result = await _getCoordinates(event.zipCode);

      emit(
        result.fold(
          (failure) => MapError(message: failure.message),
          (data) => MapSuccess(coordinates: data),
        ),
      );
    });
  }
}
