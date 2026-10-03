import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/presenter/view_models/blocs/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cepController = TextEditingController();
  final _homeBloc = HomeBloc();

  @override
  void dispose() {
    _cepController.dispose();
    _homeBloc.close();
    super.dispose();
  }

  void _searchAddress() {
    final cep = _cepController.text;
    if (cep.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um CEP com 8 dígitos.')),
      );
      return;
    }

    _homeBloc.add(GetAddressEvent(zipCode: cep));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Buscar endereço')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cepController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'CEP',
                        hintText: '00000000',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _searchAddress(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: _searchAddress,
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is HomeSuccess) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 400,
                              child: Card(child: Center(child: Text('Mapa'))),
                            ),
                            AddressDetailsCard(address: state.address),
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: Text('Informe um CEP para buscar um endereço.'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
