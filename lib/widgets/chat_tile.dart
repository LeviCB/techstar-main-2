import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/models/chat_user.dart';
import 'package:techstar/screens/home/message/chatting_screen.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.size,
    required this.chatUser,
  }) : super(key: key);

  final Size size;
  final ChatUser chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Container(
            decoration:
                DesignConfig.boxDecorationContainer(Colors.transparent, 10),
            margin: const EdgeInsets.only(bottom: 4, top: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              leading: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    child: DesignConfig.displayCourseImage(
                        StringRes.baseImageUrl + chatUser.profileImage, 25, ''),
                  ),
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
                          chatUser.username,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          chatUser.lastmessage == ""
                              ? "No chats yet..."
                              : chatUser.lastmessage,
                          //  chatUser.,
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorRes.greyColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      chatUser.readcount != "0"
                          ? CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 9,
                              child: ClipOval(
                                child: Text(
                                  chatUser.readcount,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 9,
                              child: ClipOval(
                                child: Text(
                                  chatUser.readcount,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.transparent),
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        chatUser.lastmessagetime == null
                            ? ""
                            : DateTime.now().toString().split(" ")[0] ==
                                    chatUser.lastmessagetime
                                        .toString()
                                        .split(" ")[0]
                                ? DateFormat.Hm()
                                    .format(chatUser.lastmessagetime!)
                                : DateFormat.MMMd()
                                    .format(chatUser.lastmessagetime!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorRes.greyColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
                Get.toNamed(
                  ChattingScreen.routeName,
                  arguments: {"chatuser": chatUser},
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            height: .14,
            width: double.infinity,
            color: ColorRes.greyColor,
          ),
        ),
      ],
    );
  }
}
