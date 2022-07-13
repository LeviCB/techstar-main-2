import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/user_data.dart';

class ProfileScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  Rx<UserData?> profile = null.obs;
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

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = jsonDecode(prefs.getString("userData") ?? "{}");
    var response =
        await simpleApiCaller("getUserProfile", {"user_id": userData['id']});
    if (response['status']) {
      profile = UserData.fromJson(response['data']).obs;
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
