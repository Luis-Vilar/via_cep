import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via_cep/app/presenter/view_models/blocs/bloc/map_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
                      SizedBox(
                        height: 392,
                        width: double.infinity,
                        child: Map(
                          lat: state.coordinates.lat,
                          lng: state.coordinates.lng,
                        ),
                      ),
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

class Map extends StatelessWidget {
  const new({super.key, required this.lat, required this.lng});
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(lat, lng), // Center the map over London, UK
        initialZoom: 14.5,
      ),
      children: [
        TileLayer(
          // Bring your own tiles
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
          userAgentPackageName: 'com.example.via_cep',
          tileProvider: NetworkTileProvider(
            cachingProvider: const DisabledMapCachingProvider(),
          ),
          // And many more recommended properties!
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(lat, lng),
              width: 22,
              height: 22,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 22,
              ),
            ),
          ],
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(
                Uri.parse('https://openstreetmap.org/copyright'),
              ), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }

  void launchUrl(Uri parse) {
    log(parse.toString());
  }
}
