import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/friend.dart';

class SearchFriendsScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxList<Friend> friendList = <Friend>[].obs;
  TextEditingController searchController = TextEditingController();
  late StreamSubscription<InternetConnectionStatus> connectionListner;
  @override
  void onInit() {
    connectionListner = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isConnected.value = true;
          break;
        case InternetConnectionStatus.disconnected:
          isConnected.value = false;
          break;
      }
    });
    super.onInit();
  }

  searchFriends(String text) async {
    isLoading.value = true;
    friendList.clear();
    var response = await simpleApiCaller(
      "friendlist",
      {"name": text},
    );
    if (response['status']) {
      for (var friend in response['data']) {
        friendList.add(Friend.fromJson(friend));
      }
    } else {}
    isLoading.value = false;
  }

  sendFollowRequest(String tid) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fid = jsonDecode(prefs.getString("userData").toString())['id'];
    var response = await simpleApiCaller(
      "sendrequest",
      {
        "fid": fid,
        "tid": tid,
      },
    );
    Get.snackbar(
      "Follow request",
      response['message'],
      colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      duration: const Duration(seconds: 2),
    );

    searchFriends(searchController.text);
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
