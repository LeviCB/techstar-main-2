import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/color_res.dart';

class StoryViewScreen extends StatefulWidget {
  static String routeName = '/story_view';
  const StoryViewScreen({Key? key}) : super(key: key);

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  DateTime? startTime;

  double percent = 0.0;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 3), (timer) {
      setState(() {
        percent += 0.001;
        //1/3000000 * (DateTime.now().difference(startTime!).inMicroseconds);
        if (percent > 1) {
          _timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://wallpaperaccess.com/full/2198319.jpg"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(children: [
                SizedBox(
                  height: 2.5,
                  child: LinearProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: ColorRes.greyColor,
                    value: percent,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/datingapp%2Fimage_a.jpg?alt=media&token=5c804258-20fd-4508-92e5-f2a776f110cf"),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text( 
                      "Carmen Myers",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
