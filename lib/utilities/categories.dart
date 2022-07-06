import 'package:flutter/material.dart';
import 'package:flutter_utube/constants.dart';
import 'package:flutter_utube/theme/colors.dart';

class Categories extends StatefulWidget {
  void Function(int) callback;
  int trendingIndex;
  Categories({Key? key, required this.callback, required this.trendingIndex}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Trending", "Music", "Gaming", "Movies"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: (){
        widget.trendingIndex = index;
        widget.callback(widget.trendingIndex);
      },
      child: widget.trendingIndex == index
          ? Align(
        child: Container(
          height: 38,
          width: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: pink
          ),
          child: Center(
            child: Text(
              categories[index],
              style: const TextStyle(
                  color: PrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo'
              ),
            ),
          ),
        ),
      )
          : Container(
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Text(
                categories[index],
                style: const TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'
                ),
              ),
            ),
          ),
    );
  }
}