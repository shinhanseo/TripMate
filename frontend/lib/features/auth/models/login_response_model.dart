class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  final int id;
  final String? nickname;
  final String? gender;
  final String? ageRange;
  final bool profileCompleted;

  UserModel({
    required this.id,
    required this.nickname,
    required this.gender,
    required this.ageRange,
    required this.profileCompleted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()),
      nickname: json['nickname'],
      gender: json['gender'],
      ageRange: json['age_range'],
      profileCompleted: json['profile_completed'] == true,
    );
  }
}
