import 'package:get_it/get_it.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerFactory<AddressRepositoryInterface>(
    () => throw Exception(
      'No implementado la inyección de AddressRepositoryInterface todavia',
    ),
  );
}
