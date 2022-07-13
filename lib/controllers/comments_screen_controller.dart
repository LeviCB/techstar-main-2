import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/comment.dart';
import 'package:techstar/models/post.dart';

class CommentsScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = true.obs;
  Post post = Get.arguments['post'];
  late StreamSubscription<InternetConnectionStatus> connectionListner;
  TextEditingController commentController = TextEditingController();
  RxList<Comment> comments = <Comment>[].obs;
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

  addComment() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = jsonDecode(prefs.getString("userData") ?? "{}")['id'];
    if (commentController.text.isNotEmpty) {
      var response = await simpleApiCaller(
        "addcomment",
        {
          "uid": uid,
          "pid": post.id,
          "comment": commentController.text,
        },
      );
      if (!(response['status'])) {
        Get.snackbar(
          "Error occured",
          "Error occured white adding comment.",
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
      }
      commentController.text = "";
      getData();
    } else {
      Get.snackbar(
        "Invalid comment",
        "Please enter valid comment.",
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        duration: const Duration(seconds: 2),
      );
    }
  }

  likeComment(int index) async {
    comments[index].likescount =
        (int.parse(comments[index].likescount) + 1).toString();
    comments[index].isLike = true;
    var uid = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ??
            "{}")['id'];
    simpleApiCaller("addcommentlike", {
      "uid": uid,
      "cid": comments[index].id,
    });
  }

  unlikeComment(int index) async {
    comments[index].likescount =
        (int.parse(comments[index].likescount) - 1).toString();
    comments[index].isLike = false;
    var uid = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ??
            "{}")['id'];
    simpleApiCaller("addcommentlike", {
      "uid": uid,
      "cid": comments[index].id,
    });
  }

  getData() async {
    comments.clear();
    var response = await simpleApiCaller(
      "getcomment",
      {"pid": post.id},
    );
    if (response['status']) {
      for (var comment in response['data']) {
        comments.add(Comment.fromJson(comment));
      }
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
