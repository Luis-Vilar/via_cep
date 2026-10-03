import 'package:via_cep/app/domain/entities/coordinates.dart';

final class CoordinatesModel extends Coordinates {
  new({required super.lat, required super.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      CoordinatesModel(
        lat: double.parse(json['lat']),
        lng: double.parse(json['lng']),
      );
}
