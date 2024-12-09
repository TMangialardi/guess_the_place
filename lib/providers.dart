import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/account_notifier.dart';
import 'package:guess_the_place/models/current_account.dart';

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
  debugPrint("Build CurrentAccoutProvider");
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
