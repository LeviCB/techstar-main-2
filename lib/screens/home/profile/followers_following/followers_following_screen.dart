//FollowersFollowingScreen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/followers_following_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/screens/home/profile/followers_following/tabs/sreens/followers_tab.dart';
import 'package:techstar/screens/home/profile/followers_following/tabs/sreens/following_tab.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class FollowersFollowingScreen extends StatefulWidget {
  static String routeName = '/followers_following';
  const FollowersFollowingScreen({Key? key}) : super(key: key);

  @override
  State<FollowersFollowingScreen> createState() =>
      _FollowersFollowingScreenState();
}

class _FollowersFollowingScreenState extends State<FollowersFollowingScreen>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  TabController? _controller;
  // ignore: unused_field
  int _selectedIndex = 0;
  FollowersFollowingScreenController controller =
      Get.put(FollowersFollowingScreenController());
      var args = Get.arguments;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() => setState(() {}));

    _controller = TabController(length: 2, vsync: this);
    _controller!.index = args['index'];

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: GetX(
          builder: (FollowersFollowingScreenController controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CustomLoadingIndicator(
                  size: size.width / 100 * 17.5,
                ),
              );
            } else {
              return feedsMenu();
            }
          },
        ),
      ),
    );
  }

  Widget feedsMenu() {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              shadowColor: Colors.transparent,
              snap: false,
              pinned: false,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Username",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              expandedHeight: 0,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 2,
                  controller: _controller,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: ColorRes.greyColor,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Followers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Following",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: const [
            FollowersTab(),
            FollowingTab(),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
