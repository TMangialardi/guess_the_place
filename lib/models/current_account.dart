class CurrentAccount {
  String? guidAccount;
  int? baserowLineId;
  String? username;
  String? password;
  int? personalRecord;
  CurrentAccountStatus accountStatus;
  String? accountStatusError;
  int? remainingMatches;
  int? currentScore;

  static final CurrentAccount _singleton = CurrentAccount._internal();

  CurrentAccount._internal()
      : accountStatus = CurrentAccountStatus.unregistered;

  factory CurrentAccount() {
    return _singleton;
  }

  static CurrentAccount login(
      {required guidAccount,
      required baserowLineId,
      required username,
      required password,
      required personalRecord}) {
    _singleton.guidAccount = guidAccount;
    _singleton.baserowLineId = baserowLineId;
    _singleton.username = username;
    _singleton.password = password;
    _singleton.personalRecord = personalRecord;
    _singleton.accountStatus = CurrentAccountStatus.registered;
    _singleton.accountStatusError = null;
    _singleton.remainingMatches = 5;
    _singleton.currentScore = 0;
    return _singleton;
  }

  static CurrentAccount arcade({required String username}) {
    _singleton.username = username;
    _singleton.guidAccount = null;
    _singleton.baserowLineId = null;
    _singleton.password = null;
    _singleton.personalRecord = null;
    _singleton.accountStatus = CurrentAccountStatus.arcade;
    _singleton.accountStatusError = null;
    _singleton.remainingMatches = null;
    _singleton.currentScore = null;
    return _singleton;
  }

  static CurrentAccount logout() {
    _singleton.guidAccount = null;
    _singleton.baserowLineId = null;
    _singleton.username = null;
    _singleton.password = null;
    _singleton.personalRecord = null;
    _singleton.accountStatus = CurrentAccountStatus.unregistered;
    _singleton.accountStatusError = null;
    _singleton.remainingMatches = null;
    _singleton.currentScore = null;
    return _singleton;
  }

  static CurrentAccount notifyError({required String error}) {
    _singleton.guidAccount = null;
    _singleton.baserowLineId = null;
    _singleton.username = null;
    _singleton.password = null;
    _singleton.personalRecord = null;
    _singleton.accountStatus = CurrentAccountStatus.error;
    _singleton.accountStatusError = error;
    _singleton.remainingMatches = null;
    _singleton.currentScore = null;
    return _singleton;
  }

  static CurrentAccount newGame() {
    _singleton.remainingMatches = 5;
    _singleton.currentScore = 0;
    return _singleton;
  }

  static CurrentAccount playMatch(int points) {
    _singleton.remainingMatches = _singleton.remainingMatches! - 1;
    _singleton.currentScore = _singleton.currentScore! + points;
    return _singleton;
  }
}

enum CurrentAccountStatus { unregistered, arcade, registered, error }
