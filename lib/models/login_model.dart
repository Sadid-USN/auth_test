class LoginModel {
  final Tokens? tokens;
  final User? user;

  LoginModel({
    this.tokens,
    this.user,
  });

  LoginModel.fromJson(Map<String, dynamic> json)
    : tokens = (json['tokens'] as Map<String,dynamic>?) != null ? Tokens.fromJson(json['tokens'] as Map<String,dynamic>) : null,
      user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'tokens' : tokens?.toJson(),
    'user' : user?.toJson()
  };
}

class Tokens {
  final String? accessToken;
  final String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  Tokens.fromJson(Map<String, dynamic> json)
    : accessToken = json['accessToken'] as String?,
      refreshToken = json['refreshToken'] as String?;

  Map<String, dynamic> toJson() => {
    'accessToken' : accessToken,
    'refreshToken' : refreshToken
  };
}

class User {
  final int? id;
  final String? email;
  final String? nickname;

  User({
    this.id,
    this.email,
    this.nickname,
  });

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      email = json['email'] as String?,
      nickname = json['nickname'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email' : email,
    'nickname' : nickname
  };
}