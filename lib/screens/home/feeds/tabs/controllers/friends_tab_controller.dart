import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/post.dart';

class FriendsTabController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  RxList<Post> posts = <Post>[].obs;
  var userData;

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
    userData = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ?? "{}");
    isLoading.value = true;
    posts.clear();
    var response = await simpleApiCaller("getpostbyuidDetail", {
      "uid": userData["id"],
    });
    if (response['status']) {
      for (var post in response['data']) {
        posts.add(Post.fromJson(post));
      }
    }
    isLoading.value = false;
    update();
  }

  likePost(int index) async {
    posts[index].islike = true;
    var uid = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ??
            "{}")['id'];
    simpleApiCaller("addpostlike", {
      "uid": uid,
      "pid": posts[index].id,
    });
  }

  unlikePost(int index) async {
    posts[index].islike = false;
    var uid = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ??
            "{}")['id'];
    simpleApiCaller("addpostlike", {
      "uid": uid,
      "pid": posts[index].id,
    });
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
