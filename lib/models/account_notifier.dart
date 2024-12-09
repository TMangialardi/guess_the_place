import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:guess_the_place/models/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';

class AccountNotifier extends AsyncNotifier<CurrentAccount?> {
  @override
  FutureOr<CurrentAccount?> build() {
    return null;
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();

    final hashedPassword = sha1.convert(utf8.encode(password)).toString();
    debugPrint("Calling the API...");
    final response = await http.get(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true&filters=%7B%22"
            "filter_type%22%3A%22AND%22%2C%22filters%22%3A%5B%7B%22type%22%3A%22equal%22%2C%22field%22%3A%22Username%22%2C%22value%22%3A%22$username"
            "%22%7D%2C%7B%22type%22%3A%22equal%22%2C%22field%22%3A%22Password%22%2C%22value%22%3A%22$hashedPassword%22%7D%5D%2C%22groups%22%3A%5B%5D%7D"),
        headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});
    debugPrint("URI: ${response.request?.url.toString()}");
    debugPrint("API called: ${response.body} checking status code...");
    if (response.statusCode != 200) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Couldn't check account information, try again later."));
      return;
      //throw Exception("Couldn't check account information, try again later.");
    }
    Map<String, dynamic> rawAccount = jsonDecode(response.body);
    final account = UserData.fromJson(rawAccount);
    debugPrint("checking if result is valid...");
    if (account.results?.isEmpty ?? true) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Account not found or password not valid."));
      return;
    }
    debugPrint("Checking if there is more than one account...");
    if (account.results!.length > 1) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Account error, contact the administrator."));
      return;
    }
    debugPrint("calling the login method");

    state = AsyncValue.data(CurrentAccount.login(
        guidAccount: account.results![0].guidAccount,
        username: account.results![0].username!,
        password: account.results![0].password,
        personalRecord:
            int.parse(account.results![0].personalRecord ?? "-99999")));
  }

  Future<void> arcadeLogin(String username) async {
    state = AsyncValue.data(CurrentAccount.arcade(username: username));
  }

  Future<void> registerAndLogin(String username, String password) async {
    state = const AsyncValue.loading();

    final response = await http.get(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true&filters=%7B%22filter_type%22%3A%22AND%22%2C%22"
            "filters%22%3A%5B%7B%22type%22%3A%22equal%22%2C%22field%22%3A%22Username%22%2C%22value%22%3A%22$username%22%7D%5D%2C%22groups%22%3A%5B%5D%7D"),
        headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});

    if (response.statusCode != 200) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Couldn't check account information, try again later."));
      return;
      //throw Exception("Couldn't check account information, try again later.");
    }
    Map<String, dynamic> rawAccount = jsonDecode(response.body);
    final account = UserData.fromJson(rawAccount);

    if (account.results == null) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Account information error, contact the administrator."));
      return;
      //throw Exception("Account information error, contact the administrator.");
    }

    if (account.results!.isNotEmpty) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "There is already an account with that username."));
      return;
      //throw Exception("There is already an account with that username.");
    }

    final hashedPassword = sha1.convert(utf8.encode(password)).toString();

    final Map accountToCreate = {
      'username': username,
      'password': hashedPassword,
      'personalRecord': 0,
    };

    final creation = await http.post(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true"),
        body: json.encode(accountToCreate),
        headers: {
          'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE',
          'Content-Type': 'application/json'
        });

    if (creation.statusCode != 200) {
      state = AsyncValue.data(CurrentAccount.notifyError(
          error: "Error during the creation of the account, try again."));
      return;
      //throw Exception("Error during the creation of the account, try again.");
    }

    dynamic rawCreatedAccount = jsonDecode(creation.body);
    final createdAccount =
        Results.fromJson(rawCreatedAccount.cast<Map<String, dynamic>>());

    CurrentAccount.login(
        guidAccount: createdAccount.guidAccount,
        username: createdAccount.username!,
        password: createdAccount.password,
        personalRecord: int.parse(createdAccount.personalRecord ?? "-99999"));

    state = AsyncValue.data(CurrentAccount());
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(CurrentAccount.logout());
  }
}
