import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/friend_tile.dart';

import '../../controllers/search_friends_screen_controller.dart';

class SearchFriendsScreen extends StatefulWidget {
  static String routeName = '/search_friends';
  const SearchFriendsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchFriendsScreen> createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
  SearchFriendsScreenController controller = Get.put(
    SearchFriendsScreenController(),
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX(builder: (SearchFriendsScreenController controller) {
      if (controller.isConnected.value) {}
      return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: controller.searchController,
            cursorWidth: 2,
            style: const TextStyle(color: ColorRes.white, fontSize: 19),
            cursorColor: ColorRes.greyColor,
            onFieldSubmitted: (text) {
              controller.searchFriends(text);
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              focusColor: ColorRes.white,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 0.8),
              ),
              hintText: "Search",
              hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                    const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 19.0,
                        color: ColorRes.greyColor),
                  ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
                  child: Icon(
                    Icons.search,
                    color: ColorRes.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          elevation: 3,
        ),
        body: SafeArea(
          child: controller.isLoading.value
              ? Center(
                  child: CustomLoadingIndicator(size: size.width / 100 * 15),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.friendList.length,
                  itemBuilder: (_, index) {
                    return FriendTile(
                      friend: controller.friendList[index],
                      index: index,
                      size: size,
                      isSearch: true,
                      controller: controller,
                    );
                  },
                ),
        ),
      );
    });
  }
}
