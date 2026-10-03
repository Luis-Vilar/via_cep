import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/domain/entities/address.dart';
import 'package:via_cep/app/presenter/view_models/blocs/bloc/home_bloc.dart';
import 'package:via_cep/app/presenter/view_models/blocs/bloc/map_bloc.dart';
import 'package:via_cep/app/presenter/views/home_page/components/address_details_card.dart';

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
                      final address = state.address;
                      return SingleChildScrollView(
                        child: MapCard(address: address),
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

class MapCard extends StatelessWidget {
  const new({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: BlocProvider(
            create: (context) =>
                MapBloc()..add(GetCoordinates(zipCode: address.cep)),
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                if (state is MapLoading) {
                  return Card(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is MapSuccess) {
                  return Card(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.coordinates.lat.toString()),
                          Text(state.coordinates.lng.toString()),
                        ],
                      ),
                    ),
                  );
                }
                if (state is MapError) {
                  return Card(child: Center(child: Text(state.message)));
                }
                return Card(child: Center(child: Text('Mapa não encontrado')));
              },
            ),
          ),
        ),
        AddressDetailsCard(address: address),
      ],
    );
  }
}
