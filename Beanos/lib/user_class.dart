class UserInfo {
  final String name;
  final String profilePicture;
  final String description;
  bool over_18;

  UserInfo(
      {required this.name,
        required this.profilePicture,
        required this.description,
        required this.over_18});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        name: json['display_name'],
        profilePicture: json['icon_img'],
        description: json['public_description'],
        over_18: json['over_18']);
  }
}

class AccountInfo {
  final UserInfo userInfo;

  AccountInfo({
    required this.userInfo,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(userInfo: UserInfo.fromJson(json['subreddit']));
  }
}
