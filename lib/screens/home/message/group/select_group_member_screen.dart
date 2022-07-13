import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/select_group_member_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class SelectGroupMemberScreen extends StatefulWidget {
  const SelectGroupMemberScreen({Key? key}) : super(key: key);
  static String routeName = "/select_members";

  @override
  State<SelectGroupMemberScreen> createState() =>
      _SelectGroupMemberScreenState();
}

class _SelectGroupMemberScreenState extends State<SelectGroupMemberScreen> {
  SelectGroupMemberScreenController controller =
      Get.put(SelectGroupMemberScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (SelectGroupMemberScreenController controller) {
        
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text(
              "Add Members",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: controller.isLoading.value
              ? Center(
                  child: Center(
                    child: CustomLoadingIndicator(
                      size: MediaQuery.of(context).size.width / 100 * 17,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.users.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              if (controller.selectedUsers
                                  .contains(controller.users[index])) {
                                controller.deSelectUser(index);
                              } else {
                                controller.selectUser(index);
                              }
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Container(
                                    decoration:
                                        DesignConfig.boxDecorationContainer(
                                            Colors.transparent, 10),
                                    margin: const EdgeInsets.only(
                                        bottom: 4, top: 4),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 5),
                                      leading: SizedBox(
                                        width: 50,
                                        child: Stack(
                                          children: <Widget>[
                                            DesignConfig.displayCourseImage(
                                              StringRes.baseImageUrl +
                                                  controller.users[index]
                                                      .profileImage,
                                              22.5,
                                              "",
                                            ),
                                            Visibility(
                                              visible: controller.selectedUsers
                                                  .contains(
                                                      controller.users[index]),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                  right: 2,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.5,
                                                      ),
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                controller
                                                    .users[index].username,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                controller.users[index].bio,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: ColorRes.greyColor,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              controller.submitSelectedUser();
            },
            child: const Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}
