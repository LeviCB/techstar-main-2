import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techstar/models/group_message.dart';

class GroupSenderChatTile extends StatelessWidget {
  const GroupSenderChatTile({
    Key? key,
    required this.chat,
    required this.isSended,
  }) : super(key: key);

  final GroupMessage chat;
  final bool isSended;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                chat.messages,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateTime.now().toString().split(" ")[0] ==
                      chat.createdAt.toString().split(" ")[0]
                  ? DateFormat.Hm().format(chat.createdAt)
                  : DateFormat.MMMd().format(chat.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            // const SizedBox(
            //   width: 10,
            // ),
            // isSended
            //     ? chat.isread == "0"
            //         ? const Icon(
            //             Icons.done_all,
            //             color: ColorRes.greyColor,
            //             size: 20,
            //           )
            //         : Icon(
            //             Icons.done_all,
            //             color: Theme.of(context).primaryColor,
            //             size: 20,
            //           )
            //     : const Icon(
            //         Icons.done,
            //         color: ColorRes.greyColor,
            //         size: 20,
            //       ),
          ],
        )
      ],
    );
  }
}
