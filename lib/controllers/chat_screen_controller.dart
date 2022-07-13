import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/chat_user.dart';
import 'package:techstar/models/message.dart';

class ChatScreenController extends GetxController {
  
  ChatUser user = Get.arguments['chatuser'];
  String id = "0";
  RxList<Message> messages = <Message>[].obs;
  RxBool isLoading = true.obs;
  
  RxList<Message> chatlist = <Message>[].obs;
  int sendingMessage = 0;
  RxList<Message> tempChatList = <Message>[].obs;
  RxList<Message> tempChatList2 = <Message>[].obs;
  RxList<bool?> isSended = <bool?>[].obs;
  RxList<bool?> tempIsSended = <bool?>[].obs;
  Timer? timer;
  TextEditingController messageController = TextEditingController();
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    
    timer = Timer.periodic(const Duration(seconds: 2), (t) => getData());
    super.onInit();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = jsonDecode(prefs.getString("userData").toString())['id'];
    var response = await simpleApiCaller(
      "getmessages",
      {
        "fromid": id,
        "toid": user.id,
      },
    );
    if (response['status']) {
      for (var chat in response['data']) {
        if (chat["fromid"] == id) {
          tempIsSended.add(true);
        } else {
          tempIsSended.add(null);
        }
        tempChatList.add(Message.fromJson(chat));
      }
    }
    if (sendingMessage == 0) {
      chatlist.assignAll(tempChatList);
      isSended.assignAll(tempIsSended);
    }
    tempIsSended.clear();
    tempChatList.clear();
    isLoading.value = false;
    update();
  }

  sendChat() async {
    var message = messageController.text;
    messageController.text = "";
    sendingMessage++;
    chatlist.insert(
      0,
      Message(
        fromid: id,
        toid: user.id,
        message: message,
        isread: "0",
        createdAt: DateTime.now(),
      ),
    );
    isSended.insert(0, false);
    update();
    await simpleApiCaller(
      "savemessage",
      {
        "fromid": id,
        "toid": user.id,
        "message": message,
      },
    );
    sendingMessage--;
    getData();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
