import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:line_icons/line_icons.dart';
import '/api/youtube_api.dart';
import '/widgets/video_widget.dart';

class PlayListPage extends StatefulWidget {
  final title, id;
  const PlayListPage({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {

  YoutubeApi youtubeApi = YoutubeApi();
  List contentList = [];
  bool isLoading = false;
  bool firstLoad = true;
  int loaded = 0;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(LineIcons.rss, color: Colors.white),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(LineIcons.share, color: Colors.white),
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Stack(
        children: [
          Visibility(
            visible: firstLoad,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          LazyLoadScrollView(
            isLoading: true,
            onEndOfPage: () => _loadMore(),
            child: SafeArea(
              child: ListView.builder(
                itemCount: contentList.length,
                itemBuilder: (context, index) {
                  if (contentList[index].containsKey('playlistVideoRenderer')) {
                    return video(index, contentList);
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget video(int index, List contentList) {
    return VideoWidget(
      videoId: contentList[index]['playlistVideoRenderer']['videoId'],
      duration: contentList[index]['playlistVideoRenderer']['lengthText']['simpleText'],
      title: contentList[index]['playlistVideoRenderer']['title']['runs'][0]['text'],
      channelName: contentList[index]['playlistVideoRenderer']['shortBylineText']['runs'][0]['text'],
      views: "",
    );
  }

  Future _loadMore() async {

    setState(() {
      isLoading = true;
    });
    if(loaded >= 1){
      List? newList = await youtubeApi.loadMoreInPlayList();
      if(newList != null){
        contentList.addAll(newList);
      }
    } else {
      List newList = await youtubeApi.fetchPlayListVideos(widget.id, loaded);
      contentList.addAll(newList);
    }
    loaded++;
    setState(() {
      isLoading = false;
      firstLoad = false;
    });
  }

}
