import 'dart:developer';

import 'package:via_cep/app/infra/drivers/http_client.dart';
import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';
import 'package:dio/dio.dart' hide DioError;

final class HttpClientDio implements HttpClientInterface {
  final Dio _dioClient = Dio(
    BaseOptions(
      baseUrl: 'https://viacep.com.br/',
      connectTimeout: Duration(milliseconds: 5000),
    ),
  );
  @override
  Future<Result<String, Failure>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dioClient.get(
        endpoint,
        options: Options(headers: headers),
      );
      return Success(response.data as String);
    } catch (error) {
      log(error.toString());
      return FailureResult(DioErrorDefault(error.toString()));
    }
  }
}
