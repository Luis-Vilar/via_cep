import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/entities/zip_code.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';
import 'package:via_cep/app/shared/use_case.dart';
import 'package:via_cep/core/injection.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';

class GetAddressByCepUseCase extends UseCase<Address, ZipCode> {
  final repository = injection.get<AddressRepositoryInterface>();
  @override
  Future<Result<Address, Failure>> call(ZipCode zipCode) =>
      repository.getAddress(zipCode);
}
