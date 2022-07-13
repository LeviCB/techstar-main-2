import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/screens/authentication/reset_password.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class ForgotPasswordScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxBool otpSended = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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

  sendOtp() async {
    String email = emailController.text.removeAllWhitespace;
    if (GetUtils.isEmail(email)) {
      Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',
      );
      var response = await simpleApiCaller(
        "sendotp",
        {"email": email},
      );
      Get.back();
      if (response['status']) {
        otpSended.value = true;
        Get.snackbar(
          response['message'],
          "Please enter OTP.",
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
    } else {
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

  verifyOtp() async {
    String otp = otpController.text.removeAllWhitespace;
    if (otp.length == 6) {
      Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',
      );
      var response = await simpleApiCaller(
        "verifyotp",
        {
          "email": emailController.text,
          "otp": otpController.text,
        },
      );
      Get.back();
      if (response['status']) {
        otpSended.value = true;
        Get.snackbar(
          response['message'],
          "Please enter new password.",
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
        Get.offAndToNamed(ResetPasswordScreen.routeName, arguments: {
          "email": emailController.text,
        });
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
      Get.snackbar(
        "Invalid OTP",
        "Please enter valid OTP.",
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
