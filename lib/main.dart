import 'package:flutter/material.dart';

import 'constants.dart';
import 'pages/home/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: PrimaryColor,
          scaffoldBackgroundColor: PrimaryColor
      ),
    );
  }
}