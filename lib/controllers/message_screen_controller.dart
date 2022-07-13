import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/chat_user.dart';

class MessageScreenController extends GetxController {
  
  RxBool isLoading = true.obs;
  
  RxList<ChatUser> chatlist = <ChatUser>[].obs;
  Timer? timer;
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    
    timer = Timer.periodic(const Duration(seconds: 1), (t) => getData());
    super.onInit();
  }

  getData() async {
    RxList<ChatUser> tempChatlist = <ChatUser>[].obs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = jsonDecode(prefs.getString("userData").toString())['id'];
    var response = await simpleApiCaller("chatlist", {"id": id},);
    if (response['status']) {
      for (var chatuser in response['data']) {
        tempChatlist.add(ChatUser.fromJson(chatuser));
      }
    }
    chatlist.assignAll(tempChatlist);
    isLoading.value = false;
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
