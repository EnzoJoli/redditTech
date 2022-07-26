class Settings {
  final bool over_18;
  final bool monitorMentions;
  final bool legacySearch;
  final bool enableFollowers;
  final bool videoAutoplay;
  final bool emailCommentReply;

  Settings(
      {required this.over_18,
        required this.monitorMentions,
        required this.legacySearch,
        required this.enableFollowers,
        required this.videoAutoplay,
        required this.emailCommentReply});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
        over_18: json['over_18'],
        monitorMentions: json['monitor_mentions'],
        legacySearch: json['legacy_search'],
        enableFollowers: json['enable_followers'],
        videoAutoplay: json['video_autoplay'],
        emailCommentReply: json['email_comment_reply']);
  }
}
