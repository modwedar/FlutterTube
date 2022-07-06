import 'package:flutter/material.dart';
import '/api/youtube_api.dart';
import '/widgets/video_widget.dart';

class Body extends StatefulWidget {
  List contentList;
  YoutubeApi youtubeApi;

  Body(
      {Key? key,
      required this.contentList,
      required this.youtubeApi,})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState(contentList);
}

class _BodyState extends State<Body> {
  List contentList;

  _BodyState(this.contentList);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: contentList.length,
        itemBuilder: (context, index) {
          if (contentList[index].containsKey('videoRenderer')) {
            return video(index, contentList);
          }
          return Container();
        },
      ),
    );
  }

  Widget video(int index, List contentList) {
    return VideoWidget(
      videoId: contentList[index]['videoRenderer']['videoId'],
      duration: contentList[index]['videoRenderer']['lengthText']['simpleText'],
      title: contentList[index]['videoRenderer']['title']['runs'][0]['text'],
      channelName: contentList[index]['videoRenderer']['longBylineText']['runs']
          [0]['text'],
      views: contentList[index]['videoRenderer']['shortViewCountText']
          ['simpleText'],
    );
  }
}
