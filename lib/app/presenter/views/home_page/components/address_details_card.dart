import 'package:flutter/material.dart';
import 'package:via_cep/app/domain/entities/address.dart';

class AddressDetailsCard extends StatelessWidget {
  const AddressDetailsCard({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _AddressCardItem(
                    label: 'Logradouro',
                    value: address.logadouro,
                  ),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'Complemento',
                    value: address.complemento,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _AddressCardItem(
                    label: 'Bairro',
                    value: address.bairro,
                  ),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'Localidade',
                    value: address.localidade,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _AddressCardItem(label: 'UF', value: address.uf),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'Estado',
                    value: address.estado,
                  ),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'Região',
                    value: address.regiao,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _AddressCardItem(label: 'CEP', value: address.cep),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'IBGE',
                    value: '${address.ibge}',
                  ),
                ),
                Expanded(
                  child: _AddressCardItem(
                    label: 'DDD',
                    value: '${address.ddd}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressCardItem extends StatelessWidget {
  const _AddressCardItem({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label, style: TextStyle(fontWeight: .w700)),
      subtitle: Text(value?.isNotEmpty == true ? value! : 'Não informado'),
    );
  }
}
