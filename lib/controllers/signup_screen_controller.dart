import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/screens/home/profile/editprofile_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class SignupScreenController extends GetxController {
  RxBool isConnected = true.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  final formGlobalKey = GlobalKey<FormState>();
  late StreamSubscription<InternetConnectionStatus> connectionListner;
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  signup() async {
    if (formGlobalKey.currentState!.validate()) {
      Get.dialog(
        const Center(
          child: CustomLoadingIndicator(size: 60),
        ),
        barrierDismissible: false,
        name: 'loading',
      );
      var body = {
        "email": emailController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
        "mobile": phoneController.text,
        "name": nameController.text,
        "username" : usernameController.text,
      };
      var response = await simpleApiCaller('registeruser', body);
      Get.back();
      if (response['status']) {
        Get.snackbar(
          "Welcome",
          response['message'],
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          duration: const Duration(seconds: 2),
        );
        Get.offAndToNamed(EditprofileScreen.routeName);
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
