import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/request.dart';

class PendingRequestScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  RxList<Request> requests = <Request>[].obs;
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

  getData() async {
    isLoading.value = true;
    requests.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tid = jsonDecode(prefs.getString("userData") ?? "{}")['id'];
    var response = await simpleApiCaller("requestlist", {"tid": tid});
    if (response['status']) {
      for (var request in response['data']) {
        requests.add(Request.fromJson(request));
      }
    } else {
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
