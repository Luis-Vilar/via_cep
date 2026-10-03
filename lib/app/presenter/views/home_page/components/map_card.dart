import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/presenter/view_models/blocs/bloc/map_bloc.dart';

class MapCard extends StatelessWidget {
  const new({super.key, required this.cep});

  final String cep;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: BlocProvider(
        create: (context) => MapBloc()..add(GetCoordinates(zipCode: cep)),
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLoading) {
              return Card(child: Center(child: CircularProgressIndicator()));
            }
            if (state is MapSuccess) {
              return Card(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Latitude  : ${state.coordinates.lat.toString()}'),
                      Text('Longitude : ${state.coordinates.lng.toString()}'),
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
    );
  }
}
