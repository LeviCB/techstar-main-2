import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/chat_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/screens/others/friend_profile_screen.dart';
import 'package:techstar/widgets/message_tile/single/reciver_chat_tile.dart';
import 'package:techstar/widgets/message_tile/single/sender_chat_tile.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class ChattingScreen extends StatefulWidget {
  static String routeName = "/chat";
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  ChatScreenController controller = Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          titleSpacing: 0,
          title: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
            leading: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 23,
                  child: DesignConfig.displayCourseImage(
                      StringRes.baseImageUrl + controller.user.profileImage,
                      23,
                      ''),
                ),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  controller.user.username,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(
                FriendProfileScreen.routeName,
                arguments: {"id": controller.user.id},
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: ColorRes.greyColor,
                ))
          ],
        ),
      ),
      body: GetBuilder(
        builder: (ChatScreenController controller) {
          return Column(
            children: <Widget>[
              Expanded(
                child: controller.isLoading.value
                    ? Center(
                        child: CustomLoadingIndicator(
                          size: MediaQuery.of(context).size.width / 100 * 17,
                        ),
                      )
                    : ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.all(20),
                        itemCount: controller.chatlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              controller.chatlist[index].fromid ==
                                      controller.id
                                  ? SenderChatTile(
                                      chat: controller.chatlist[index],
                                      isSended: controller.isSended[index]!,
                                    )
                                  : ReciverChatTile(
                                      chat: controller.chatlist[index],
                                    ),
                            ],
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 58,
                color: Colors.grey.shade700,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        cursorColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        cursorHeight: 20,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration.collapsed(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Message',
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
                        if (controller.messageController.text.isNotEmpty) {
                          controller.sendChat();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
