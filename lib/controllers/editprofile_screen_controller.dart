import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/mixins/validation_mixin.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class EditProfileScreenController extends GetxController
    with InputValidationMixin {
  RxBool isLoading = false.obs;
  RxBool isImagePicked = false.obs;
  final formGlobalKey = GlobalKey<FormState>();
  RxString image = "".obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );

    loadData();
    super.onInit();
  }

  pickImage(File? selectedImage) async {
    ImagePicker _picker = ImagePicker();
    XFile? file;
    await Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                file = await _picker.pickImage(source: ImageSource.camera);
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey.shade700,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                file = await _picker.pickImage(source: ImageSource.gallery);
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade700,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (file == null) {
      if (isImagePicked.value) {
        return selectedImage;
      } else {
        return null;
      }
    } else {
      isImagePicked.value = true;
      var newFile = File(file!.path);
      var path = (await getApplicationSupportDirectory())
              .toString()
              .replaceAll("Directory: ", "")
              .replaceAll("'", "") +
          "/" +
          file!.name;
      final result = await FlutterImageCompress.compressAndGetFile(
        newFile.absolute.path,
        path,
        quality: 80,
        minWidth: 500,
        minHeight: 500,
      );
      return File(result!.path);
    }
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = jsonDecode(prefs.getString("userData") ?? "{}");
    emailController.text = userData['email'] ?? "";
    usernameController.text = userData['username'] ?? "";
    bioController.text = userData['bio'] ?? "";
    nameController.text = userData['name'] ?? "";
    phoneController.text = userData['mobile'] ?? "";
    image.value = userData['profileImage'] ?? "";
  }

  editProfile(File? imageFile) async {
    Get.dialog(
      const Center(
        child: CustomLoadingIndicator(size: 60),
      ),
      barrierDismissible: false,
      name: 'loading',
    );
    if (isPhoneNumberValid(phoneController.text)) {
      if (isUsernameValid(usernameController.text)) {
        if (isUsernameValid(nameController.text)) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var userData = jsonDecode(prefs.getString("userData") ?? "{}");
          dynamic response;
          if (imageFile == null) {
            response = await multipartRequestApiCaller(
              "editProfile",
              {
                "id": userData['id'],
                "username": usernameController.text,
                "mobile": phoneController.text,
                "name": nameController.text,
                "bio": bioController.text,
              },
              [],
            );
          } else {
            response = await multipartRequestApiCaller(
              "editProfile",
              {
                "id": userData['id'],
                "username": usernameController.text,
                "mobile": phoneController.text,
                "name": nameController.text,
                "bio": bioController.text,
              },
              [
                await http.MultipartFile.fromPath(
                    'profileImage', imageFile.path),
              ],
            );
          }
          Get.back();
          if (response['status']) {
            Get.back();
            Get.snackbar(
              "Profile Updated.",
              response['message'],
              colorText: Colors.white,
              margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              duration: const Duration(seconds: 2),
            );
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("userData", jsonEncode(response['data'][0]));
          } else {
            Get.snackbar(
              "Error occured.",
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
            "Please enter valid name.",
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
          "Please enter valid username.",
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
        "Please enter valid phone number.",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        duration: const Duration(seconds: 2),
      );
    }
  }
}
