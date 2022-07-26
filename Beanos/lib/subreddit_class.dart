
class Data {
  final String type;
  SubReddit subReddit;

  Data(
      {required this.subReddit,
        required this.type});

  factory Data.init() {
    return Data(
        type: "",
        subReddit: SubReddit.init()
    );
  }

  factory Data.fromJson(Map<String, dynamic> json, String type) {
    if (type == "subscribe") {
      return Data(
          type: type,
          subReddit: SubReddit.fromJson(json['data']));
    } else {
      return Data(
          type: type,
          subReddit: SubReddit.init());
    }
  }
}

class SubReddit {
  final String name;
  final String icon;
  final String icon2;
  final String title;
  final int nbSub;
  final String description;
  final String headerImg;
  final bool subbed;

  SubReddit(
      {required this.name,
        required this.icon,
        required this.title,
        required this.nbSub,
        required this.description,
        required this.headerImg,
        required this.icon2,
        required this.subbed});

  factory SubReddit.fromJson(Map<String, dynamic> json) {
    return SubReddit(
        name: json['display_name_prefixed'],
        icon: json['community_icon'],
        title: json['title'],
        nbSub: json['subscribers'] as int,
        description: json['description'],
        headerImg: json['header_img'] ?? "",
        icon2: json['icon_img'] ?? "",
        subbed: json['user_is_subscriber'] as bool);
  }

  factory SubReddit.init() {
    return SubReddit(
        name: "",
        icon: "",
        title: "",
        nbSub: 0,
        description: "",
        headerImg: "",
        icon2: "",
        subbed: false);
  }
}