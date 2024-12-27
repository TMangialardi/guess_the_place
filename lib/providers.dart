import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/account_notifier.dart';
import 'package:guess_the_place/models/current_account.dart';
import 'package:guess_the_place/models/game_match.dart';
import 'package:guess_the_place/models/latest_matches_data.dart';
import 'package:guess_the_place/models/leaderboard_data.dart';
import 'package:guess_the_place/models/match_notifier.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

final darkThemeProvider = StateProvider.autoDispose((ref) {
  debugPrint("Building darkThemeProvider");
  return true;
});

final aboutTextProvider = FutureProvider.autoDispose((ref) async {
  debugPrint("Build aboutTextProvider");
  return await rootBundle.loadString('assets/docs/about.txt');
});

final currentAccountProvider =
    AsyncNotifierProvider<AccountNotifier, CurrentAccount?>(() {
  debugPrint("Build currentAccoutProvider");
  return AccountNotifier();
});

final loginUsernameProvider = StateProvider((ref) {
  debugPrint("Building loginUsernameProvider");
  return "";
});

final loginPasswordProvider = StateProvider((ref) {
  debugPrint("Building loginPasswordProvider");
  return "";
});

final matchProvider = AsyncNotifierProvider<MatchNotifier, GameMatch?>(() {
  debugPrint("Build matchProvider");
  return MatchNotifier();
});

final pickedCoordinatesProvider = StateProvider<LatLng>((ref) {
  debugPrint("Building pickedCoordinatesProvider");
  return const LatLng(43.6841, 13.2433);
});

final latestResultProvider = StateProvider.autoDispose((ref) {
  debugPrint("Building latestResultProvider");
  return 0;
});

final remainingMatchesProvider = StateProvider((ref) {
  debugPrint("Building remainingMatchesProvider");
  return 0;
});

final currentScoreProvider = StateProvider((ref) {
  debugPrint("Building currentScoreProvider");
  return 0;
});

final matchHistoryProvider = FutureProvider((ref) async {
  debugPrint("calling match history API...");
  final response = await http.get(
      Uri.parse(
          "https://api.baserow.io/api/database/rows/table/400571/?user_field_names=true&order_by=-DateTime"),
      headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});

  if (response.statusCode != 200) {
    debugPrint("Match history API error: ${response.body}");
    throw Exception("Error getting match history data");
  }

  debugPrint("Match history API sucess: ${response.body}");
  Map<String, dynamic> rawHistory = jsonDecode(response.body);
  var history = LatestMatchesData.fromJson(rawHistory);

  return history.results;
});

final leaderboardProvider = FutureProvider.autoDispose((ref) async {
  debugPrint("calling leaderboard API...");
  final response = await http.get(
      Uri.parse(
          "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true&order_by=-PersonalRecord&include=Username,PersonalRecord"),
      headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});

  if (response.statusCode != 200) {
    debugPrint("Leaderboard API error: ${response.body}");
    throw Exception("Error getting match history data");
  }

  debugPrint("Leaderboard API sucess: ${response.body}");
  Map<String, dynamic> rawLeaderboard = jsonDecode(response.body);
  var leaderboard = LeaderboardData.fromJson(rawLeaderboard);

  return leaderboard.results;
});
