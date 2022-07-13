import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class ChangePasswordScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmNewPasswordVisible = false.obs;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
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

  changePassword() async {
    if (formGlobalKey.currentState!.validate()) {
      Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',
      );
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userData = jsonDecode(pref.getString("userData") ?? "{}");

      var body = {
        "id": userData['id'],
        "password": passwordController.text,
        "confirm_password": newPasswordController.text,
      };
      var response = await simpleApiCaller('Changepassword', body);
      Get.back();
      if (response['status']) {
        Get.back();
        Get.snackbar(
          response['message'],
          "Please login to continue.",
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
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
    }
  }

  @override
  void dispose() {
    connectionListner.pause();
    super.dispose();
  }
}
// Changepassword

// id
// password
// confirm_password