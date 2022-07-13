import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/helper/api_caller.dart';
import 'package:techstar/models/profile.dart';
import 'package:techstar/screens/home/message/group/create_group_screen.dart';

class SelectGroupMemberScreenController extends GetxController {
  
  RxBool isLoading = true.obs;
  
  RxList<Profile> users = <Profile>[].obs;
  RxList<Profile> selectedUsers = <Profile>[].obs;
  @override
  void onInit() {
    
    getData();
    super.onInit();
  }

  getData() async {
    var userData = jsonDecode(
        (await SharedPreferences.getInstance()).getString("userData") ?? "{}");
    var response = await simpleApiCaller(
      "friend",
      {
        "uid": userData!["id"],
      },
    );
    if (response['status']) {
      for (var user in response['data']) {
        users.add(Profile.fromJsonMember(user));
      }
    }
    isLoading.value = false;
    update();
  }

  selectUser(int index) {
    selectedUsers.add(users[index]);
    update();
  }

  deSelectUser(int index) {
    selectedUsers.remove(users[index]);
    update();
  }

  submitSelectedUser() {
    Get.toNamed(CreateGroupScreen.routeName, arguments: selectedUsers);
  }

  
}
