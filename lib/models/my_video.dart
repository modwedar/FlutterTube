class MyVideo {
  String videoId,
      title,
      date,
      username,
      viewCount,
      likeCount,
      unlikeCount,
      channelThumb,
      channelId;
  String? subscribeCount;

  MyVideo(
      {required this.videoId,
      required this.title,
      required this.username,
      required this.viewCount,
      this.subscribeCount,
      required this.likeCount,
      required this.unlikeCount,
      required this.date,
      required this.channelThumb,
      required this.channelId});
}
