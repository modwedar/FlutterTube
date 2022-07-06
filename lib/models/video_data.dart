import 'package:flutter_utube/models/my_video.dart';

class VideoData {
  MyVideo video;
  List<Map<String, dynamic>>? videosList;

  VideoData({required this.video, required this.videosList});
}