import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/entities/coordinates.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';

abstract interface class AddressRepositoryInterface {
  Future<Result<Address, Failure>> getAddress(String zipCode);
  Future<Result<Coordinates, Failure>> getCoordinates(String zipCode);
}
