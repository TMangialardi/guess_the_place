import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:guess_the_place/models/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';

class AccountNotifier extends AsyncNotifier<CurrentAccount> {
  @override
  FutureOr<CurrentAccount> build() {
    return CurrentAccount();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();

    final hashedPassword = sha1.convert(utf8.encode(password)).toString();

    final response = await http.get(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true&filter__username__equal=$username&filter__password__equal=$hashedPassword&filter_type=and"),
        headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});

    if (response.statusCode != 200) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Couldn't check account information, try again later.");
    }
    List<dynamic> rawAccount = jsonDecode(response.body);
    final account = rawAccount
        .cast<Map<String, dynamic>>()
        .map((e) => UserData.fromJson(e))
        .toList();

    if (account[0].results?.isEmpty ?? true) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Account not found or password not valid.");
    }

    if (account[0].results!.length > 1) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Account error, contact the administrator.");
    }

    CurrentAccount.registered(
        guidAccount: account[0].results![0].guidAccount,
        username: account[0].results![0].username!,
        password: account[0].results![0].password,
        personalRecord: account[0].results![0].personalRecord);

    state = AsyncValue.data(CurrentAccount());
  }

  Future<void> arcadeLogin(String username) async {
    state = const AsyncValue.loading();
    CurrentAccount.unregistered(username: username);
    state = AsyncValue.data(CurrentAccount());
  }

  Future<void> registerAndLogin(String username, String password) async {
    state = const AsyncValue.loading();

    final response = await http.get(
        Uri.parse(
            "https://api.baserow.io/api/database/rows/table/400552/?user_field_names=true&filter__username__equal=$username"),
        headers: {'Authorization': 'Token Y2Uuiqq1rX36hHPWnd3A5dK3Vo6D9kwE'});

    if (response.statusCode != 200) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Couldn't check account information, try again later.");
    }
    List<dynamic> rawAccount = jsonDecode(response.body);
    final account = rawAccount
        .cast<Map<String, dynamic>>()
        .map((e) => UserData.fromJson(e))
        .toList();

    if (account[0].results == null) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Account information error, contact the administrator");
    }

    if (account[0].results!.isNotEmpty) {
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("There is already an account with that username.");
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
      state = AsyncValue.error("error", StackTrace.current);
      throw Exception("Error during the creation of the account, try again.");
    }

    dynamic rawCreatedAccount = jsonDecode(creation.body);
    final createdAccount =
        Results.fromJson(rawCreatedAccount.cast<Map<String, dynamic>>());

    CurrentAccount.registered(
        guidAccount: createdAccount.guidAccount,
        username: createdAccount.username!,
        password: createdAccount.password,
        personalRecord: createdAccount.personalRecord);

    state = AsyncValue.data(CurrentAccount());
  }
}
