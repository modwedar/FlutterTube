import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '/api/youtube_api.dart';
import '/helpers/suggestion_history.dart';
import '/widgets/channel_widget.dart';
import '/widgets/playList_widget.dart';
import '/widgets/video_widget.dart';

class SearchPage extends StatefulWidget {
  String query;

  SearchPage(this.query);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  YoutubeApi _youtubeApi = YoutubeApi();
  List? contentList;
  bool isLoading = false;
  bool firstLoad = true;

  @override
  void initState() {
    contentList = [];
    _loadMore(widget.query);
    SuggestionHistory.store(widget.query);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Stack(
        children: [
          Visibility(
            visible: firstLoad,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => _loadMore(widget.query),
            child: ListView.builder(
              itemCount: contentList!.length,
              itemBuilder: (context, index) {
                if (isLoading && index == contentList!.length - 1) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (contentList![index].containsKey('videoRenderer')) {
                    return video(index, contentList!);
                  } else if (contentList![index]
                      .containsKey('channelRenderer')) {
                    return channel(index, contentList!);
                  } else if (contentList![index]
                      .containsKey('playlistRenderer')) {
                    return playList(index, contentList!);
                  }
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget video(int index, List contentList) {
    var lengthText = contentList[index]['videoRenderer']['lengthText'];
    var simpleText = contentList[index]['videoRenderer']['shortViewCountText']['simpleText'];
    return VideoWidget(
      videoId: contentList[index]['videoRenderer']['videoId'],
      duration: (lengthText == null) ? "Live" : lengthText['simpleText'],
      title: contentList[index]['videoRenderer']['title']['runs'][0]['text'],
      channelName: contentList[index]['videoRenderer']['longBylineText']['runs']
          [0]['text'],
      views: (lengthText == null) ? "Views " + contentList[index]['videoRenderer']['viewCountText']['runs'][0]['text'] : simpleText ,
    );
  }

  Widget playList(int index, List contentList) {
    return PlayListWidget(
      id: contentList[index]['playlistRenderer']['playlistId'],
      thumbnails: contentList[index]['playlistRenderer']['thumbnails'][0]['thumbnails'],
      videoCount: contentList[index]['playlistRenderer']['videoCount'],
      title: contentList[index]['playlistRenderer']['title']['simpleText'],
      channelName: contentList[index]['playlistRenderer']['shortBylineText']['runs'][0]['text'],
    );
  }


  Widget channel(int index, List contentList) {
    return ChannelWidget(
      id: contentList[index]['channelRenderer']['channelId'],
      thumbnail: contentList[index]['channelRenderer']['thumbnail']
          ['thumbnails'][0]['url'],
      title: contentList[index]['channelRenderer']['title']['simpleText'],
      videoCount: contentList[index]['channelRenderer']['videoCountText']
          ['runs'][0]['text'],
    );
  }

  Future _loadMore(String query) async {
    setState(() {
      isLoading = true;
    });
    List newList = await _youtubeApi.fetchSearchVideo(query);
    contentList!.addAll(newList);
    setState(() {
      isLoading = false;
      firstLoad = false;
    });
  }
}
