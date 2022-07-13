import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FollowersTabController extends GetxController {
  RxBool isConnected = true.obs;
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
    getData();
    super.onInit();
  }

  getData() {
    Timer(const Duration(seconds: 2), () {
    });
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
