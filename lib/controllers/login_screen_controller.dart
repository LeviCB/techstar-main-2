import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/screens/home/home_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
class LoginScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
    super.onInit();
  }

  login() async {
    String email = emailController.text.removeAllWhitespace;
    String password = passwordController.text.removeAllWhitespace;
    Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',);
    if (GetUtils.isEmail(email)) {
      if (password.length >= 6) {
        var response = await simpleApiCaller(
          'login',
          {
            "email": email,
            "password": password,
          },
        );
        Get.back();
        if (response['status']) {
          Get.snackbar(
          "Welcome",
          response['message'],
            colorText: Colors.white,
            margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            duration: const Duration(seconds: 2),
          );
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("userData", jsonEncode(response['data'][0]));
          Get.offAndToNamed(HomeScreen.routeName);
        } else {
          Get.snackbar(
            "Error occured",
            response['message'],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.back();
        Get.snackbar(
          "Invalid Credentials",
          "Please enter valid password.",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      Get.back();
      Get.snackbar(
        "Invalid Credentials",
        "Please enter valid email.",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
