class ProfileModel {
  final int? id;
  final String? email;
  final String? nickname;

  ProfileModel({
    this.id,
    this.email,
    this.nickname,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      email = json['email'] as String?,
      nickname = json['nickname'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email' : email,
    'nickname' : nickname
  };
}