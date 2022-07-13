import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/profile.dart';

class FriendProfileScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  RxBool isButtonsVisible = false.obs;
  Rx<Profile?> profile = null.obs;
  var args = Get.arguments;
  late StreamSubscription<InternetConnectionStatus> connectionListner;
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
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
    getData();
    super.onInit();
  }

  sendFriendRequest() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fid = jsonDecode(prefs.getString("userData").toString())['id'];
    var response = await simpleApiCaller(
      "sendrequest",
      {
        "fid": fid,
        "tid": args['id'],
      },
    );
    Get.snackbar(
      "Follow request",
      response['message'],
      colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      duration: const Duration(seconds: 2),
    );

    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = jsonDecode(prefs.getString("userData") ?? "{}");
    isButtonsVisible.value = args['id'] != userData['id'];
    var response =
        await simpleApiCaller("viewFriendProfile", {"tid": args['id']});
    if (response['status']) {
      profile = Profile.fromJson(response['data']['profile']).obs;
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
