import 'package:flutter/material.dart';
import 'package:flutter_utube/constants.dart';
import 'dart:async';

import '/api/youtube_api.dart';
import '/helpers/suggestion_history.dart';
import '/pages/search_page.dart';

class DataSearch extends SearchDelegate<String> {
  Timer? _timer;

  final YoutubeApi _youtubeApi = YoutubeApi();

  final list = SuggestionHistory.suggestions;


  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     appBarTheme: const AppBarTheme(
  //       color: PrimaryColor, // affects AppBar's background color
  //     ),
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPage(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      List<String> suggestions = list.reversed.toList();
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              query = suggestions[index];
              showResults(context);
            },
            child: ListTile(
              leading: Icon(Icons.north_west),
              title: Text(suggestions[index]),
              trailing: Icon(Icons.history_outlined),
            ),
          );
        },
        itemCount: suggestions.length,
      );
    }
    return FutureBuilder(
      future: _youtubeApi.fetchSuggestions(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var snapshots = snapshot.data;
          List<String> suggestions = query.isEmpty ? list : snapshots;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  list.add(query);
                  query = suggestions[index];
                  showResults(context);
                },
                child: ListTile(
                  leading: Icon(Icons.north_west),
                  title: Text(suggestions[index]),
                ),
              );
            },
            itemCount: suggestions.length,
          );
        }
        return Container();
      },
    );
  }
}
