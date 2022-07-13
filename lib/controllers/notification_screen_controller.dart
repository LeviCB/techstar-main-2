import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NotificationScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  late StreamSubscription<InternetConnectionStatus> connectionListner;
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.light
      ),
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

  getData() {
    Timer(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}