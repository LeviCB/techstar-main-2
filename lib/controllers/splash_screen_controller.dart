import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:techstar/screens/authentication/login_screen.dart';
import 'package:techstar/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  RxBool isConnected = true.obs;
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonDecode(pref.getString("userData") ?? 'null');
    Timer(const Duration(seconds: 2), () {
      if (data == null) {
        Get.offAndToNamed(LoginScreen.routeName);
      } else {
        Get.offAndToNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
