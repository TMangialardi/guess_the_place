class CurrentAccount {
  String? guidAccount;
  String username;
  String? password;
  int? personalRecord;

  static final CurrentAccount _singleton =
      CurrentAccount._internal(username: "");

  CurrentAccount._internal({required this.username});

  factory CurrentAccount() {
    return _singleton;
  }

  CurrentAccount.registered(
      {required this.guidAccount,
      required this.username,
      required this.password,
      required this.personalRecord}) {
    guidAccount = guidAccount;
    username = username;
    password = password;
    personalRecord = personalRecord;
  }

  CurrentAccount.unregistered({required this.username}) {
    username = username;
    guidAccount = null;
    password = null;
    personalRecord = -99999;
  }
}
