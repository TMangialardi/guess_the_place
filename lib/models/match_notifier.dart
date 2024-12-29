import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/game_match.dart';
import 'package:guess_the_place/models/latest_matches_data.dart';
import 'package:guess_the_place/models/mapillary_data.dart';
import 'package:guess_the_place/providers.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MatchNotifier extends AsyncNotifier<GameMatch?> {
  @override
  FutureOr<GameMatch?> build() {
    return state.value;
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
          "${coordinates.longitude - 0.5},${coordinates.latitude - 0.5},${coordinates.longitude + 0.5},${coordinates.latitude + 0.5}&limit=5"));
      debugPrint("URI: ${response.request?.url.toString()}");
      debugPrint("API called: ${response.body} checking status code...");
      if (response.statusCode != 200) {
        debugPrint("Error calling Mapillary API");
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

  Future<void> saveMatch({required String arcadeName}) async {
    final realCoordinates = state.value!.coordinates;
    final guessedCoordinates = ref.watch(pickedCoordinatesProvider);

    debugPrint(
        "real coordinates: ${realCoordinates.latitude}|${realCoordinates.longitude}");
    debugPrint(
        "guessed coordinates: ${guessedCoordinates.latitude}|${guessedCoordinates.longitude}");
    const distanceCalculator = Distance();

    final distance = distanceCalculator.as(
        LengthUnit.Kilometer, realCoordinates, guessedCoordinates);

    debugPrint("distance: $distance");

    final int points;

    if (distance <= 100) {
      points = 5000;
    } else if (distance > 100 && distance <= 5100) {
      points = 5000 - (distance.round() - 100);
    } else {
      points = 0;
    }

    debugPrint("points: $points");

    ref.read(latestResultProvider.notifier).state = points;

    if (ref.watch(currentAccountProvider).value!.guidAccount != null) {
      debugPrint("Saving points of registered account");
      ref.watch(currentScoreProvider.notifier).state += points;
      ref.watch(remainingMatchesProvider.notifier).state -= 1;
    }

    final Map<String, String> matchToSave = {
      'ArcadeName': ref.watch(currentAccountProvider).value!.username!,
      'DateTime': DateTime.now().toUtc().toIso8601String(),
      'MatchLat': realCoordinates.latitude.toStringAsFixed(4),
      'MatchLon': realCoordinates.longitude.toStringAsFixed(4),
      'GuessedLat': guessedCoordinates.latitude.toStringAsFixed(4),
      'GuessedLon': guessedCoordinates.longitude.toStringAsFixed(4),
      'Points': points.toString(),
    };
    debugPrint(jsonEncode(matchToSave));
    final creation = await http.post(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400571/?user_field_names=true"),
        body: json.encode(matchToSave),
        headers: {
          'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE',
          'Content-Type': 'application/json'
        });
    debugPrint(creation.body);
    if (creation.statusCode != 200) {
      debugPrint("Error saving the match data");
    } else {
      debugPrint("Match saved successfully");
      Map<String, dynamic> rawMatchData = jsonDecode(creation.body);
      final matchData = MatchResults.fromJson(rawMatchData);

      final removal = await http.delete(
          Uri.parse(
              "https://api.baserow.io/api/database/rows/table/400571/${(matchData.id! - 100)}/"),
          body: json.encode(matchToSave),
          headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});
      if (removal.statusCode != 204) {
        debugPrint("Error removing old match data");
      } else {
        debugPrint("Old match removed successfully");
      }
    }
  }
}
