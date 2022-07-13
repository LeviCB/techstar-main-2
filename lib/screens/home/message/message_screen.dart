import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/message_screen_controller.dart';
import 'package:techstar/screens/home/message/group/select_group_member_screen.dart';
import 'package:techstar/widgets/chat_tile.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  MessageScreenController controller = Get.put(MessageScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat List"),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 26,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return {"create": "Create Group"}.entries.map((choice) {
                      return PopupMenuItem<String>(
                        value: choice.key,
                        child: Text(choice.value),
                      );
                    }).toList();
                  },
                  onSelected: (value) {
                    if (value == "create") {
                      Get.toNamed(SelectGroupMemberScreen.routeName);
                    }
                  },
                ),
              ],
            )
          ],
        ),
        body: GetX(
          builder: (MessageScreenController controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CustomLoadingIndicator(
                  size: size.width / 100 * 17,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: size.height - (size.height / 100 * 27.2),
                      child: ListView.builder(
                          itemCount: controller.chatlist.length,
                          // itemCount: controller.chatlist.length + 1,
                          itemBuilder: (_, index) {
                            // if (index==0) {
                            //   return InkWell(
                            //     onTap: () {
                            //       Get.toNamed(GroupMessageScreen.routeName);
                            //     },
                            //     child: Column(
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(
                            //               top: 15,
                            //               bottom: 15,
                            //               left: 15,
                            //               right: 15),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: const [
                            //               Text(
                            //                 "Group chats",
                            //                 style: TextStyle(
                            //                     fontSize: 16,
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w400),
                            //               ),
                            //               Padding(
                            //                 padding: EdgeInsets.only(right: 8),
                            //                 child: Icon(
                            //                   Icons.arrow_forward_ios_rounded,
                            //                   color: ColorRes.greyColor,
                            //                   size: 20,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 0, right: 0),
                            //           child: Container(
                            //             height: .14,
                            //             width: double.infinity,
                            //             color: ColorRes.greyColor,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   );
                            // }
                            return ChatTile(
                              chatUser: controller.chatlist[index],
                              size: size,
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
