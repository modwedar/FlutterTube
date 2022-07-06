import 'package:flutter/material.dart';
import '/pages/channel/channel_page.dart';

class ChannelWidget extends StatelessWidget {
  final String id, thumbnail, title, videoCount;
  ChannelWidget({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.videoCount,
});

  @override
  Widget build(BuildContext context) {
    String imgUrl = thumbnail;
    if (!imgUrl.startsWith("https")) {
      imgUrl = "https://" + imgUrl.substring(2);
    }
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChannelPage(id: id, title: title)),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 30, left: 30, top: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: Image.network(imgUrl).image, fit: BoxFit.cover)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    videoCount +
                        "فيديو" +
                        "•",
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                        fontFamily: 'Cairo'
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
