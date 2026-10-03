import 'package:via_cep/app/shared/result_pattern.dart';

abstract class HttpClientInterface {
  Future<Result> get(String endpoint, {Map<String, String>? headers});
}
