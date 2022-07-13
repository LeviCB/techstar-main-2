import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:techstar/controllers/friend_profile_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/screens/home/profile/Gallary_Model.dart';
import 'package:techstar/screens/home/profile/followers_following/followers_following_screen.dart';
import 'package:techstar/screens/home/profile/single_post_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class FriendProfileScreen extends StatefulWidget {
  static String routeName = '/friend_profile';
  const FriendProfileScreen({Key? key}) : super(key: key);

  @override
  _FriendProfileScreenState createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  FriendProfileScreenController controller =
      Get.put(FriendProfileScreenController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Friend Profile",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: GetX(builder: (FriendProfileScreenController controller) {
        return controller.isLoading.value
            ? Center(
                child: CustomLoadingIndicator(
                    size: MediaQuery.of(context).size.width / 100 * 17),
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
                            image: const CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/datingapp%2Fprofilepic.jpg?alt=media&token=32c9e3f5-57a0-4caf-b176-bb801fea6181",
                            ),
                            placeholderBuilder: OctoPlaceholder.blurHash(
                              "LgJa[zIU%\$xt9ZxaxuNG~qbb?Hoz",
                            ),
                            errorBuilder: OctoError.icon(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            width: 135,
                            height: 135,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Center(
                      child: Text(
                        "Username",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isButtonsVisible.value,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      controller.sendFriendRequest();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context).primaryColor),
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5))),
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          child: Text(
                                            "Follow",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: ColorRes.greyColor),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Padding(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        child: Text(
                                          "Message",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                            children: const [
                              Center(
                                child: Text(
                                  "12",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Center(
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
                              children: const [
                                Center(
                                  child: Text(
                                    "159",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Center(
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
                              children: const [
                                Center(
                                  child: Text(
                                    "420",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Center(
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
                        )),
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                          color: Colors.white,
                          indent: 0,
                          endIndent: 0,
                        )),
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                          color: Colors.white,
                          indent: 0,
                          endIndent: 0,
                        )),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: List.generate(gallaryList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (() {
                                Get.toNamed(SinglePostScreen.routeName);
                              }),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: OctoImage(
                                  image: CachedNetworkImageProvider(
                                    gallaryList[index].imgurl!,
                                  ),
                                  placeholderBuilder: OctoPlaceholder.blurHash(
                                    gallaryList[index].hash!,
                                  ),
                                  errorBuilder: OctoError.icon(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width / 5.2,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
