import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/screens/authentication/login_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class ResetPasswordScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  var args = Get.arguments;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  resetPassword() async {
    if (formGlobalKey.currentState!.validate()) {
      Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',
      );
      var body = {
        "email" : args['email'],
        "password": passwordController.text,
      };
      var response = await simpleApiCaller('forgotpassword', body);
      Get.back();
      if (response['status']) {
        Get.snackbar(
          response['message'],
          "Login to continue",
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
        Get.offAndToNamed(LoginScreen.routeName);
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
