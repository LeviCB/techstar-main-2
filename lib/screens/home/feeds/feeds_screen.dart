import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/feeds_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/screens/home/feeds/tabs/screens/friends_tab.dart';
import 'package:techstar/screens/home/feeds/tabs/screens/live_tab.dart';
import 'package:techstar/screens/home/feeds/tabs/screens/trending_tab.dart';
import 'package:techstar/screens/others/search_friends_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  TabController? _controller;
  // ignore: unused_field
  int _selectedIndex = 0;
  FeedsScreenController controller = Get.put(FeedsScreenController());
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() => setState(() {}));

    _controller = TabController(length: 3, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GetX(
        builder: (FeedsScreenController controller) {
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
    );
  }

  Widget feedsMenu() {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              shadowColor: Colors.transparent,
              snap: false,
              pinned: false,
              floating: true,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Feeds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              expandedHeight: 0,
              actions: [
                Visibility(
                  visible: _controller!.index == 1,
                  maintainAnimation: true,
                  maintainState: true,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(SearchFriendsScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
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
                        "Live",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Friends",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Trending",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
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
            LiveTab(),
            FriendsTab(),
            TrendingTab(),
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
