import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/entities/zip_code.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';

abstract interface class AddressRepositoryInterface {
  Future<Result<Address, Failure>> getAddress(ZipCode zipCode);
}
