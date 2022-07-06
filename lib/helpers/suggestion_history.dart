import 'package:shared_preferences/shared_preferences.dart';

class SuggestionHistory{
  static List<String> suggestions = [];

  static void store(String  query) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(suggestions.length > 10){
      suggestions.removeAt(0);
    }
    if(suggestions.contains(query)){
      suggestions.removeWhere((suggestion) => suggestion == query);
    }
    suggestions.add(query);
    await prefs.setStringList('suggestions', suggestions);
  }

  static void init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    suggestions =  prefs.getStringList('suggestions')!;
  }
}