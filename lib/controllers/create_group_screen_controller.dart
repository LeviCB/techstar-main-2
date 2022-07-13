import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:techstar/screens/home/home_screen.dart';

class CreateGroupScreenController extends GetxController {
  RxBool isImagePicked = false.obs;
  RxList<Profile> selectedUsers = Get.arguments as RxList<Profile>;
  TextEditingController groupNameController = TextEditingController();
  RxString image = "".obs;
  File? imageFile;
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

  createGroup() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonDecode(pref.getString("userData") ?? '{}');
    dynamic response;
    if (imageFile == null) {
      response = await multipartRequestApiCaller(
        "creategroup",
        {
          "name": groupNameController.text,
          "created_by": data['id'],
        },
        [],
      );
    } else {
      response = await multipartRequestApiCaller(
        "creategroup",
        {
          "name": groupNameController.text,
          "created_by": data['id'],
        },
        [
          await http.MultipartFile.fromPath('image', imageFile!.path),
        ],
      );
    }
    if (response['status']) {
      var parameters = {"users": []};
      for (var user in selectedUsers) {
        parameters["users"]!.add(
          {
            "gid": response['groupid'],
            "uid": user.id,
          },
        );
      }
      var addMembersResponse = await simpleApiCaller("addmembers", parameters);
      if (addMembersResponse['status']) {
        Get.offAllNamed(HomeScreen.routeName, arguments: {"index": 1},);
      }
    }
  }
}
