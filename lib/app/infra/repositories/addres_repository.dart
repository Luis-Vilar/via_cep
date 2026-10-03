import 'dart:developer';

import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/entities/zip_code.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';
import 'package:via_cep/app/infra/drivers/http_client.dart';
import 'package:via_cep/app/infra/models/address_model.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';
import 'package:via_cep/core/injection.dart';

final class AddressRepository implements AddressRepositoryInterface {
  final _httpClient = injection.get<HttpClientInterface>();
  @override
  Future<Result<Address, Failure>> getAddress(ZipCode zipCode) async {
    try {
      final response = await _httpClient.get('ws/$zipCode/xml/');

      log(response.data);

      if (response.isFailure) {
        return response.failure;
      } else {
        return Success(AddressModel.fromXml(response.data));
      }
    } catch (e) {
      return FailureResult(RepoErrorDefault(e.toString()));
    }
  }
}
