import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/game_match.dart';
import 'package:guess_the_place/models/mapillary_data.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MatchNotifier extends AsyncNotifier<GameMatch?> {
  @override
  FutureOr<GameMatch?> build() {
    return null;
  }

  Future<void> newMatch() async {
    state = const AsyncValue.loading();
    final random = Random();
    LatLng? coordinates;
    String? mapillaryCode;
    bool keepTrying = true;
    do {
      coordinates = LatLng(
          (random.nextDouble() * 180) - 90, (random.nextDouble() * 360) - 180);
      debugPrint("Calling Mapillary API...");
      final response = await http.get(Uri.parse(
          "https://graph.mapillary.com/images?access_token=MLY|8426886974094861|f893688326346a2713136e0e15290d5a&fields=id&bbox="
          "${coordinates.latitude - 0.5},${coordinates.longitude - 0.5},${coordinates.latitude + 0.5},${coordinates.longitude + 0.5}&limit=5"));
      debugPrint("URI: ${response.request?.url.toString()}");
      debugPrint("API called: ${response.body} checking status code...");
      if (response.statusCode != 200) {
        state =
            AsyncValue.error("Error calling Mapillary API", StackTrace.current);
        continue;
      }
      Map<String, dynamic> rawMapillaryData = jsonDecode(response.body);
      final mapillaryData = MapillaryData.fromJson(rawMapillaryData);
      if (mapillaryData.data!.isNotEmpty) {
        mapillaryCode = mapillaryData.data![0].id;
        keepTrying = false;
      }
    } while (keepTrying);

    state = AsyncData(
        GameMatch(coordinates: coordinates, mapillaryCode: mapillaryCode!));
  }
}
