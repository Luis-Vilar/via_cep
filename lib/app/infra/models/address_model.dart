import 'package:via_cep/app/domain/entities/address.dart';

final class AddressModel extends Address {
  new({
    required super.cep,
    required super.logadouro,
    required super.bairro,
    required super.localidade,
    required super.uf,
    required super.estado,
    required super.regiao,
    required super.ibge,
    required super.gia,
    required super.ddd,
    required super.siafi,
  });
}
