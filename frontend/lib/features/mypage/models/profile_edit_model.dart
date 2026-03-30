class ProfileEditModel {
  final String nickname;
  final String bio;
  final List<String> category;
  final String profileImageUrl;

  ProfileEditModel({
    required this.nickname,
    required this.bio,
    required this.category,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'bio': bio,
      'category': category,
      'profileImageUrl': profileImageUrl,
    };
  }
}
