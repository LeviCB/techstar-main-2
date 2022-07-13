import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:techstar/models/message.dart';

class ReciverChatTile extends StatelessWidget {
  const ReciverChatTile({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final Message chat;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Text(
                  chat.message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    height: 1.2,
                    color: Colors.white,
                  ),
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
