import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/comments_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/widgets/comment_tile.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class CommentsScreen extends StatefulWidget {
  static String routeName = '/comments';
  const CommentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  CommentsScreenController controller = Get.put(CommentsScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX(builder: (CommentsScreenController controller) {
      if (controller.isConnected.value) {}
      return Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          elevation: 0,
        ),
        body: controller.isLoading.value
            ? Center(
                child: CustomLoadingIndicator(
                  size: MediaQuery.of(context).size.width / 100 * 17,
                ),
              )
            : Column(
                children: [
                  controller.comments.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Container(
                                decoration: DesignConfig.boxDecorationContainer(
                                    Colors.transparent, 10),
                                margin:
                                    const EdgeInsets.only(bottom: 4, top: 4),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  leading: Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        child: DesignConfig.displayCourseImage(
                                          StringRes.baseImageUrl +
                                              controller
                                                  .post.profileImage,
                                          25,
                                          '',
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            controller.post.username,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            controller.post.description,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: ColorRes.greyColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: ColorRes.greyColor,
                              ),
                            )
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.comments.length + 1,
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Container(
                                        decoration:
                                            DesignConfig.boxDecorationContainer(
                                                Colors.transparent, 10),
                                        margin: const EdgeInsets.only(
                                            bottom: 4, top: 4),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10, 5, 10),
                                          leading: Stack(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 25,
                                                child: DesignConfig
                                                    .displayCourseImage(
                                                  StringRes.baseImageUrl +
                                                      controller.post
                                                          .profileImage,
                                                  25,
                                                  '',
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    controller.post
                                                        .username,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    controller.post.description,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ColorRes.greyColor,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      child: Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: ColorRes.greyColor,
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return CommentTile(
                                  comment: controller.comments[index - 1],
                                  size: size,
                                  controller: controller,
                                  index: index-1,
                                );
                              }
                            },
                          ),
                        ),
                  Visibility(
                    visible: controller.comments.isEmpty,
                    child: const Expanded(
                      child: Center(
                        child: Text(
                          "No comments yet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 58,
                    color: Colors.grey.shade700,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: controller.commentController,
                            cursorColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            cursorHeight: 20,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration.collapsed(
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Comment',
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          iconSize: 25,
                          onPressed: () {
                            controller.addComment();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
      );
    });
  }
}
