import 'package:flutter/material.dart';
import 'package:flutter_utube/pages/home/subscribed_channels.dart';
import '../../constants.dart';
import '../../theme/colors.dart';
import '../../utilities/categories.dart';
import '/api/youtube_api.dart';
import '/pages/home/body.dart';
import '/utilities/custom_app_bar.dart';
import '/widgets/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  YoutubeApi youtubeApi = YoutubeApi();
  List? contentList;
  int _selectedIndex = 0;
  late Future trending;
  int trendingIndex = 0;
  late double progressPosition;

  @override
  void initState() {
    super.initState();
    trending = youtubeApi.fetchTrendingVideo();
    contentList = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    progressPosition = MediaQuery.of(context).size.height / 0.5;
    return Scaffold(
      backgroundColor: SecondaryColor,
      appBar: CustomAppBar(),
      body: body(),
      bottomNavigationBar: customBottomNavigationBar(),
    );
  }

  Widget body() {
    switch (_selectedIndex) {
      case 1:
        return SubscribedChannels();
      case 2:
        return Center(
          child: Text("TODO"),
        );
      case 3:
        return  Center(
          child: Text("TODO"),
        );
    }
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 10),
              child: Categories(
                callback: changeTrendingState,
                trendingIndex: trendingIndex,
              ),
            ),
            FutureBuilder(
              future: trending,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: loading(),
                    );
                  case ConnectionState.active:
                    return Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: loading(),
                    );
                  case ConnectionState.none:
                    return const Text("Connection None");
                  case ConnectionState.done:
                    if (snapshot.error != null) {
                      return Container(
                          child: Text(snapshot.stackTrace.toString()));
                    } else {
                      if (snapshot.hasData) {
                        contentList = snapshot.data;
                        return Body(
                            contentList: contentList!, youtubeApi: youtubeApi);
                      } else {
                        return Center(child: Container(child: Text("No data")));
                      }
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            backgroundColor: const Color(0xff424242),
            selectedItemColor: pink,
            selectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
            unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department),
                label: 'Trending',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv), label: 'Subscriptions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.cloud_download), label: 'Downloads')
            ],
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeTrendingState(int index) {
    switch (index) {
      case 0:
        setState(() {
          trending = youtubeApi.fetchTrendingVideo();
        });
        break;
      case 1:
        setState(() {
          trending = youtubeApi.fetchTrendingMusic();
        });
        break;
      case 2:
        setState(() {
          trending = youtubeApi.fetchTrendingGaming();
        });
        break;
      case 3:
        setState(() {
          trending = youtubeApi.fetchTrendingMovies();
        });
        break;
    }
    trendingIndex = index;
  }

  Future<bool> _refresh() async {
    List newList = await youtubeApi.fetchTrendingVideo();
    if(newList.isNotEmpty){
      setState(() {
        contentList = newList;
      });
      return true;
    }
    return false;
  }
}
