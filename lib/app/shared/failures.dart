abstract class Failure {
  final String message;
  const Failure(this.message);
}

final class AddressNotFound extends Failure {
  AddressNotFound() : super('Endereço não encontrado');
}

final class DioErrorDefault extends Failure {
  DioErrorDefault(String error)
    : super('Erro não tratado na implementação de dio: $error');
}

final class RepoErrorDefault extends Failure {
  RepoErrorDefault(String error)
    : super('Erro não tratado no repository : $error');
}
