import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/helpers/data_search.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2d2d2d),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xff2d2d2d),
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0.5,
      title: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset("assets/logo.png", width: 200),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
            icon: Icon(
              Icons.manage_search,
              size: 37,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}