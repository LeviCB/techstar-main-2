import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/screens/home/feeds/story_view.dart';
import 'package:techstar/screens/home/feeds/tabs/controllers/friends_tab_controller.dart';
import 'package:techstar/screens/home/profile/Gallary_Model.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/feed_tile.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  FriendsTabController controller = Get.put(FriendsTabController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder(builder: (FriendsTabController controller) {
      if (controller.isConnected.value) {}
      return RefreshIndicator(
        onRefresh: () async {
          await controller.getData();
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.posts.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5.5,
                                    right: 5.5,
                                    top: 12,
                                    // bottom: 5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.5),
                                            child: Container(
                                              height: 65,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    width: 3),
                                                shape: BoxShape.circle,
                                                image: const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/datingapp%2Fimage_a.jpg?alt=media&token=5c804258-20fd-4508-92e5-f2a776f110cf"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 13,
                                            right: 5,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1.5),
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5.5,
                                    right: 5.5,
                                    top: 12,
                                    // bottom: 5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(StoryViewScreen.routeName);
                                    },
                                    child: Container(
                                      height: 68,
                                      width: 68,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            const Color.fromARGB(
                                                255, 157, 234, 157),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.5),
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                width: 3),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  gallaryList[index]
                                                      .imgurl
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isLoading.value,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Center(
                            child: CustomLoadingIndicator(
                              size:
                                  MediaQuery.of(context).size.width / 100 * 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return FeedTile(
                    index: index - 1,
                    post: controller.posts[index - 1],
                    size: size,
                    friendsTabController: controller,
                    trendingTabController: null,
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
