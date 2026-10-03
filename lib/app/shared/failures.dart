abstract class Failure {
  final String message;
  const Failure(this.message);
}

final class AddressNotFound extends Failure {
  AddressNotFound() : super('Endereço não encontrado');
}
