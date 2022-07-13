import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/screens/home/feeds/tabs/controllers/trending_tab_controller.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/feed_tile.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  TrendingTabController controller = Get.put(TrendingTabController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX(builder: (TrendingTabController controller) {
      if (controller.isConnected.value) {}
      return Scaffold(
        body: controller.isLoading.value
            ? Center(
                child: CustomLoadingIndicator(
                  size: MediaQuery.of(context).size.width / 100 * 17,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (_, index) {
                    return FeedTile(
                      index: index,
                      post: controller.posts[index],
                      size: size,
                      friendsTabController: null,
                      trendingTabController: controller,
                    );
                  },
                ),
              ),
      );
    });
  }
}
