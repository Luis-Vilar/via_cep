abstract class Address {
  Address({
    required this.cep,
    required this.logadouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.estado,
    required this.regiao,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
    this.complemento,
    this.unidade,
  });
  String cep;
  String logadouro;
  String? complemento;
  String? unidade;
  String bairro;
  String localidade;
  String uf;
  String estado;
  String regiao;
  int ibge;
  int gia;
  int ddd;
  int siafi;
}
