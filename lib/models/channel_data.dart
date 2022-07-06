import 'package:shared_preferences/shared_preferences.dart';

import '/models/channel.dart';
import '/api/helpers/helpers_extention.dart';
import 'package:collection/collection.dart';


class ChannelData {
  Channel channel;
  List videosList;
  bool isSubscribed = false;

  ChannelData({required this.channel, required this.videosList});

  factory ChannelData.fromMap(Map<String, dynamic> map) {
    var headers = map.get('header');
    String? subscribers = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('subscriberCountText')?['simpleText'];
    var thumbnails = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('avatar')
        ?.getList('thumbnails');
    String avatar = thumbnails?.elementAtSafe(thumbnails.length - 1)?['url'];
    String? banner = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('banner')
        ?.getList('thumbnails')
        ?.first['url'];
    var contents = map
        .get('contents')
        ?.get('twoColumnBrowseResultsRenderer')
        ?.getList('tabs')?[1]
        .get('tabRenderer')
        ?.get('content')
        ?.get('sectionListRenderer')
        ?.getList('contents')
        ?.firstOrNull
        ?.get('itemSectionRenderer')
        ?.getList('contents')
        ?.firstOrNull
        ?.get('gridRenderer')
        ?.getList('items');
    List list = contents!.toList();
    return ChannelData(videosList: list, channel: Channel(subscribers: (subscribers != null) ? subscribers : " ", avatar: avatar, banner: banner));
  }

  void checkIsSubscribed(String channelId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? s = sharedPreferences.getString(channelId);
    if(s == null){
      isSubscribed = false;
    } else {
      isSubscribed = true;
    }
  }
}
