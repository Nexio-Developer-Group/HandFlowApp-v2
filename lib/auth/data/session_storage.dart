class Session {
  static final Session _instance = Session._internal();
  factory Session() => _instance;
  Session._internal();

  String? email;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  void clear() {
    email = null;
    accessToken = null;
    refreshToken = null;
    expiresIn = null;
  }

  bool get isEmpty => email == null;

  bool get isNotEmpty => !isEmpty;
}
