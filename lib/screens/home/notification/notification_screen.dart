import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/notification_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/screens/home/notification/pending_request_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationScreenController controller =
      Get.put(NotificationScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 26,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 26,
                    )),
              ],
            )
          ],
        ),
        body: GetX(
          builder: (NotificationScreenController controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CustomLoadingIndicator(
                  size: size.width / 100 * 17.5,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: size.height - (size.height / 100 * 27.2),
                      child: ListView.builder(
                          itemCount: 5 + 1,
                          itemBuilder: (_, index) {
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      title: "Coming Soon...",
                                      message: "Functionality coming soon..",
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 15,
                                          right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Friend requests",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ColorRes.greyColor,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      child: Container(
                                        height: .14,
                                        width: double.infinity,
                                        color: ColorRes.greyColor,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return NotificationTile(
                                index: index - 1,
                                size: size,
                              );
                            }
                          }),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
