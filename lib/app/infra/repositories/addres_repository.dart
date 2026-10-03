import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/domain/entities/coordinates.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';
import 'package:via_cep/app/infra/drivers/http_client.dart';
import 'package:via_cep/app/infra/models/address_model.dart';
import 'package:via_cep/app/infra/models/coordinates_model.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';
import 'package:via_cep/core/injection.dart';
import 'package:xml/xml.dart';

final class AddressRepository implements AddressRepositoryInterface {
  final _httpClient = injection.get<HttpClientInterface>();
  @override
  Future<Result<Address, Failure>> getAddress(String zipCode) async {
    try {
      log(zipCode);
      final response = await _httpClient.get(
        'https://viacep.com.br/ws/$zipCode/xml/',
      );

      return await response.fold((failure) => FailureResult(failure), (data) {
        log(data);
        final document = XmlDocument.parse(data);
        final hasError =
            document.rootElement
                .getElement('erro')
                ?.innerText
                .trim()
                .toLowerCase() ==
            'true';

        if (hasError) {
          return FailureResult(AddressNotFound());
        }

        return Success(AddressModel.fromXml(data));
      });
    } catch (e) {
      return FailureResult(RepoErrorDefault(e.toString()));
    }
  }

  @override
  Future<Result<Coordinates, Failure>> getCoordinates(String zipCode) async {
    final response = await _httpClient.get(
      'https://cep.awesomeapi.com.br/json/$zipCode',
    );

    return response.fold((failure) => FailureResult(failure), (data) {
      try {
        return Success(CoordinatesModel.fromJson(jsonDecode(data)));
      } catch (e) {
        return FailureResult(RepoErrorDefault(e.toString()));
      }
    });
  }
}
