import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/use_cases/get_address_by_cep.dart';
import 'package:via_cep/app/shared/result_pattern.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _getAddressUseCase = GetAddressByCepUseCase();

  HomeBloc() : super(HomeInitial()) {
    on<GetAddressEvent>((event, emit) async {
      emit(HomeLoading());
      final result = await _getAddressUseCase(event.zipCode);

      if (result is Success) {
        final address = result.data;
        emit(HomeSuccess(address: address!));
      }
      if (result is FailureResult) {
        emit(HomeError(message: result.failure!.message));
      }
    });
  }
}
