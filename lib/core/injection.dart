import 'package:get_it/get_it.dart';
import 'package:via_cep/app/domain/interfaces/address_repository_interface.dart';
import 'package:via_cep/app/infra/drivers/http_client.dart';
import 'package:via_cep/app/infra/repositories/addres_repository.dart';
import 'package:via_cep/app/infra/sources/remote/http_client_dio.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerFactory<HttpClientInterface>(
    //
    () => HttpClientDio(),
  );
  injection.registerFactory<AddressRepositoryInterface>(
    //
    () => AddressRepository(),
  );
}
