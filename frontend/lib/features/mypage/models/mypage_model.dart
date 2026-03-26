class MyPageModel {
  final int userId;
  final String nickname;
  final String gender;
  final String ageRange;
  final String? bio;
  final List<String>? favoriteTags;
  final String profileImage;

  MyPageModel({
    required this.userId,
    required this.nickname,
    required this.gender,
    required this.ageRange,
    this.bio,
    this.favoriteTags,
    required this.profileImage,
  });

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    return MyPageModel(
      userId: int.parse(json['id'].toString()),
      nickname: json['nickname'] as String,
      gender: json['gender'] as String,
      ageRange: json['ageRange'] as String,
      bio: json['bio'] as String?,
      favoriteTags: (json['favoriteTags'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      profileImage: (json['profileImage'] ?? '') as String,
    );
  }
}
