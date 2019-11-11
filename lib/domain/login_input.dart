class LoginInput {
  String login;
  String senha;

  toMap() {
    return {
      "login": login,
      "senha": senha,
    };
  }
}

class LoginResponse {
  final bool status;
  final String msg;

  LoginResponse.fromJson(Map<String, dynamic> map)
      : status = map["status"] == "OK",
        msg = map["msg"];
}