import 'package:via_cep/app/shared/failures.dart';
import 'package:via_cep/app/shared/result_pattern.dart';

abstract class UseCase<Output, Params> {
  Future<Result<Output, Failure>> call(Params params);
}

final class NoParams {}
