import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/create_group_screen_controller.dart';
import 'package:techstar/helper/string_res.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);
  static String routeName = "/create_group";

  @override
  State<CreateGroupScreen> createState() => CreateGroupScreenState();
}

class CreateGroupScreenState extends State<CreateGroupScreen> {
  CreateGroupScreenController controller =
      Get.put(CreateGroupScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Create Group",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetX(
        builder: (CreateGroupScreenController controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await (controller.imageFile =
                              await controller.pickImage(controller.imageFile));
                          setState(
                            () {},
                          );
                        },
                        child: controller.image.value != ""
                            ? controller.isImagePicked.value
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image:
                                              FileImage(controller.imageFile!),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              StringRes.baseImageUrl +
                                                  controller.image.value),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 112.5,
                        child: TextField(
                          cursorHeight: 20,
                          controller: controller.groupNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            hintText: "Type your group name here...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade300.withOpacity(0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Provide a group name and optional group icon",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Participants: ${controller.selectedUsers.length}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 17.5,
                      crossAxisSpacing: 7.5,
                    ),
                    itemCount: controller.selectedUsers.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(StringRes.baseImageUrl +
                                      controller
                                          .selectedUsers[index].profileImage),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.selectedUsers[index].username,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          controller.createGroup();
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
