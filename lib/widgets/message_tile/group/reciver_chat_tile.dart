import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:techstar/models/group_message.dart';

class GroupReciverChatTile extends StatelessWidget {
  const GroupReciverChatTile({
    Key? key,
    required this.chat,
    required this.showName,
  }) : super(key: key);

  final GroupMessage chat;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !showName,
                      child: Column(
                        children: [
                          Text(
                            chat.username,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      chat.messages,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Row(
          children: [
            Text(
              DateTime.now().toString().split(" ")[0] ==
                      chat.createdAt.toString().split(" ")[0]
                  ? DateFormat.Hm().format(chat.createdAt)
                  : DateFormat.MMMd().format(chat.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
