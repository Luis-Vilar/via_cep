import 'package:via_cep/app/domain/entities/address.dart';
import 'package:xml/xml.dart';

final class AddressModel extends Address {
  AddressModel({
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
    super.complemento,
    super.unidade,
  });

  factory AddressModel.fromXml(String xml) {
    final document = XmlDocument.parse(xml);
    final address = document.rootElement;

    String value(String tag) => address.getElement(tag)?.innerText.trim() ?? '';
    int number(String tag) => int.parse(value(tag));

    return AddressModel(
      cep: number('cep'),
      logadouro: value('logradouro'),
      complemento: value('complemento'),
      unidade: value('unidade'),
      bairro: value('bairro'),
      localidade: value('localidade'),
      uf: value('uf'),
      estado: value('estado'),
      regiao: value('regiao'),
      ibge: number('ibge'),
      gia: number('gia'),
      ddd: number('ddd'),
      siafi: number('siafi'),
    );
  }
}
