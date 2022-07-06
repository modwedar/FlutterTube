import 'dart:convert';

import 'package:flutter_utube/models/subscribed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  SharedPreferences? sharedPreferences;

  Future<List<Subscribed>> getSubscribedChannels() async {

    sharedPreferences = await SharedPreferences.getInstance();
    List<Subscribed> subscribedChannels = [];
    List<String>? idsList = await _getSubscribedChannelsIds();
    idsList?.forEach((id) async {
      Subscribed subscribed = await _getSubscribedChannel(id);
      subscribedChannels.add(subscribed);
    });
    return subscribedChannels;
  }

  Future<Subscribed> _getSubscribedChannel(String channelId) async {
    String? str = sharedPreferences!.getString(channelId);
    return Subscribed.fromJson(jsonDecode(str!));
  }

  Future<List<String>?> _getSubscribedChannelsIds() async {
    List<String>? subscribedChannelsIds = sharedPreferences!.getStringList('subscribedChannelsIds');
    return subscribedChannelsIds;
  }

  void _addSubscribedChannelsId(String channelId) async {
    List<String>? list = await _getSubscribedChannelsIds();
    list ??= [];
    list.add(channelId);
    sharedPreferences!.setStringList("subscribedChannelsIds",list);
  }

  void _removeSubscribedChannelsId(String channelId) async {
    List<String>? list = await _getSubscribedChannelsIds();
    if(list != null){
      list.remove(channelId);
      sharedPreferences!.setStringList("subscribedChannelsIds",list);
    }
  }

  void subscribeChannel(String channelId, String user) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString(channelId, user);
    _addSubscribedChannelsId(channelId);
  }

  void unSubscribeChannel(String channelId)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.remove(channelId);
    _removeSubscribedChannelsId(channelId);
  }
}