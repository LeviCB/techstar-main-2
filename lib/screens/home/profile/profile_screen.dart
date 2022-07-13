import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:techstar/controllers/profile_screen_controller.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/screens/home/profile/followers_following/followers_following_screen.dart';
import 'package:techstar/screens/home/profile/single_post_screen.dart';
import 'package:techstar/screens/home/profile/settings_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:video_player/video_player.dart';

class ProfileActivity extends StatefulWidget {
  const ProfileActivity({Key? key}) : super(key: key);

  @override
  _ProfileActivityState createState() => _ProfileActivityState();
}

class _ProfileActivityState extends State<ProfileActivity> {
  ProfileScreenController controller = Get.put(
    ProfileScreenController(),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetX(
      builder: (ProfileScreenController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text(
              "Profile",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(SettingsSceen.routeName);
                },
                icon: const Icon(Icons.settings),
              )
            ],
          ),
          body: controller.isLoading.value
              ? Center(
                  child: CustomLoadingIndicator(size: width / 100 * 17),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: ClipOval(
                            child: OctoImage(
                              image: CachedNetworkImageProvider(
                                StringRes.baseImageUrl +
                                    controller
                                        .profile.value!.profile.profileImage,
                              ),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                "LgJa[zIU%\$xt9ZxaxuNG~qbb?Hoz",
                              ),
                              errorBuilder: OctoError.icon(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: 135,
                              height: 135,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: Text(
                          controller.profile.value!.profile.username,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    controller.profile.value!.profile.postcount
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    "Posts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(FollowersFollowingScreen.routeName,
                                    arguments: {"index": 0});
                              },
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      controller.profile.value!.profile.followers
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "Followers",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(FollowersFollowingScreen.routeName,
                                    arguments: {"index": 1});
                              },
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      controller.profile.value!.profile.following
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "Following",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.white,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.white,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.white,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: List.generate(
                              controller.profile.value!.posts.length, (index) {
                            VideoPlayerController? videocontroller;
                            if (controller.profile.value!.posts[index].image ==
                                    "" ||
                                controller.profile.value!.posts[index].image ==
                                    "null") {
                              videocontroller =
                                  VideoPlayerController.contentUri(Uri.parse(
                                      StringRes.baseImageUrl +
                                          controller.profile.value!.posts[index]
                                              .video));
                              videocontroller.play();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    SinglePostScreen.routeName,
                                    arguments: {
                                      "profile":
                                          controller.profile.value!.profile,
                                      "post": controller
                                          .profile.value!.posts[index],
                                      "isVideo": controller.profile.value!
                                                  .posts[index].image ==
                                              "" ||
                                          controller.profile.value!.posts[index]
                                                  .image ==
                                              "null"
                                    },
                                  );
                                },
                                child: controller.profile.value!.posts[index]
                                                .image ==
                                            "" ||
                                        controller.profile.value!.posts[index]
                                                .image ==
                                            "null"
                                    ? Container(
                                        child: VideoPlayer(videocontroller!),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              StringRes.baseImageUrl +
                                                  controller.profile.value!
                                                      .posts[index].image,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
