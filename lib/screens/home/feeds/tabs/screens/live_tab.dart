import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/screens/home/feeds/story_view.dart';
import 'package:techstar/screens/home/feeds/tabs/controllers/live_tab_controller.dart';
import 'package:techstar/screens/home/profile/Gallary_Model.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/feed_tile.dart';

class LiveTab extends StatefulWidget {
  const LiveTab({
    Key? key,
  }) : super(key: key);

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  LiveTabController controller = Get.put(LiveTabController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(builder: (LiveTabController controller) {
      if (controller.isConnected.value) {}
      return const Scaffold(
        body: Center(
          child: Text("No friends are live.",style: TextStyle(color: Colors.white),),
        ),
      );
    });
  }
}
