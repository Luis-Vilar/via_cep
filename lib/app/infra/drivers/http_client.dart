import 'package:via_cep/app/shared/result_pattern.dart';
import 'package:via_cep/app/shared/failures.dart';

abstract class HttpClientInterface {
  Future<Result<String, Failure>> get(
    String endpoint, {
    Map<String, String>? headers,
  });
}
