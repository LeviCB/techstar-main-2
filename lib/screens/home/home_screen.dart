import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/home_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/screens/home/camera/camera_screen.dart';
import 'package:techstar/screens/home/feeds/feeds_screen.dart';
import 'package:techstar/screens/home/message/message_screen.dart';
import 'package:techstar/screens/home/notification/notification_screen.dart';
import 'package:techstar/screens/home/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.put(
    HomeScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX(
      builder: (HomeScreenController controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.curIndex.value == 0) {
              return true;
            } else {
              controller.curIndex.value = 0;
              controller.pageController.value.jumpTo(0);
              return false;
            }
          },
          child: Scaffold(
            bottomNavigationBar: design(
              size: size,
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                unselectedItemColor: ColorRes.labelColor,
                elevation: 0.0,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "",
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.curIndex.value,
                selectedItemColor: Theme.of(context).primaryColor,
                onTap: (int index) {
                  controller.pageController.value.jumpToPage(index);
                  controller.curIndex.value = index;
                },
              ),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                controller.curIndex.value = index;
              },
              controller: controller.pageController.value,
              children: [
                const FeedsScreen(),
                const MessageScreen(),
                CameraPage(),
                const NotificationScreen(),
                const ProfileActivity(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget design({required Widget child, dynamic size}) {
    return SizedBox(
        child:
            ClipRRect(borderRadius: BorderRadius.circular(20), child: child));
  }
}
