import 'package:via_cep/app/domain/entities/coordinates.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';
import 'package:via_cep/app/shared/use_case.dart';
import 'package:via_cep/core/injection.dart';

class GetCoordinatesByCep extends UseCase<Coordinates, String> {
  final repository = injection.get<AddressRepositoryInterface>();

  @override
  Future<Result<Coordinates, Failure>> call(String zipCode) {
    return repository.getCoordinates(zipCode);
  }
}
