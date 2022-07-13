import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/search_friends_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/models/friend.dart';
import 'package:techstar/screens/others/friend_profile_screen.dart';

class FriendTile extends StatefulWidget {
  const FriendTile({
    Key? key,
    required this.friend,
    required this.size,
    required this.index,
    required this.isSearch,
    this.controller,
  }) : super(key: key);

  final Size size;
  final Friend friend;
  final int index;
  final bool isSearch;
  final SearchFriendsScreenController? controller;

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(FriendProfileScreen.routeName, arguments: {"id":widget.friend.id});
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration:
                  DesignConfig.boxDecorationContainer(Colors.transparent, 10),
              margin: const EdgeInsets.only(bottom: 4, top: 4),
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                leading: Stack(
                  children: <Widget>[
                    DesignConfig.displayCourseImage(
                        StringRes.baseImageUrl + widget.friend.profileImage,
                        22.5,
                        ''),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.friend.username,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.friend.bio,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ColorRes.greyColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
