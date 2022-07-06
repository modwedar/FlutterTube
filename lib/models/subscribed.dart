class Subscribed {
  String username, channelId, avatar, videosCount;

  Subscribed(
      {required this.username,
      required this.channelId,
      required this.avatar,
      required this.videosCount});

  factory Subscribed.fromJson(Map<String, dynamic> parsedJson) {
    return Subscribed(
      username: parsedJson['username'] ?? "",
      channelId: parsedJson['channelId'] ?? "",
      avatar: parsedJson['avatar'] ?? "",
      videosCount: parsedJson['videosCount'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "channelId": channelId,
      "avatar": avatar,
      "videosCount": videosCount,
    };
  }
}
