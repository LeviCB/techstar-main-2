import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techstar/screens/authentication/change_password.dart';
import 'package:techstar/screens/authentication/login_screen.dart';
import 'package:techstar/screens/home/profile/editprofile_screen.dart';

class SettingsSceen extends StatefulWidget {
  static String routeName = '/settings';
  const SettingsSceen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingsSceenState();
  }
}

class SettingsSceenState extends State<SettingsSceen> {
  bool notificationSwitch = true,
      appNotificationSwitch = false,
      tLogin = true,
      fLogin = false,
      gLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Stack(fit: StackFit.loose, children: [settingDta()])));
  }

  Widget settingDta() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
      child: Column(
        children: [
          account(),
          line(),
          editPro(),
          changePwd(),
          logout(),
          notification(),
          line(),
          notificationData(),
          appNotificationData(),
          more(),
          line(),
          aboutUs(),
          contactUs(),
          feedBack(),
          term(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget account() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        children: const [
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Account",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: const Divider(
        height: 1,
        color: Color(0xffacacac),
      ),
    );
  }

  Widget editPro() {
    return arrowTile(
        name: "Edit Profile",
        onPressed: () {
          Get.toNamed(EditprofileScreen.routeName);
        });
  }

  Widget changePwd() {
    return arrowTile(
        name: "Change Password",
        onPressed: () {
          Get.toNamed(ChangePasswordScreen.routeName);
        });
  }

  Widget notification() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        children: const [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget notificationData() {
    return switchTile("Notifications", notificationSwitch, 1);
  }

  Widget appNotificationData() {
    return switchTile("App Notifications", appNotificationSwitch, 2);
  }

  Widget more() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        children: const [
          Icon(
            Icons.add_box_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "More",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget aboutUs() {
    return arrowTile(name: "About Us", onPressed: () {});
  }

  Widget contactUs() {
    return arrowTile(name: "Contact Us", onPressed: () {});
  }

  Widget feedBack() {
    return arrowTile(name: "Feedback", onPressed: () {});
  }

  Widget term() {
    return arrowTile(name: "Terms and Conditions", onPressed: () {});
  }

  Widget logout() {
    return arrowTile(
        name: "Logout",
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: Text("Logout"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("Do you want to logout ?",
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        height: 1.3)),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new FlatButton(
                        child: new Text(
                          "NO",
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      FlatButton(
                        child: new Text(
                          "YES",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15),
                        ),
                        onPressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.clear();
                          Get.offAllNamed(LoginScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            barrierColor: Theme.of(context).scaffoldBackgroundColor,
            barrierDismissible: false,
          );
        });
  }

  Widget switchTile(String name, bool switchData, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Text(
          name,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
        ),
        trailing: Container(
          padding: const EdgeInsets.only(left: 45),
          child: Transform.scale(
            alignment: Alignment.centerRight,
            scale: 0.65,
            child: CupertinoSwitch(
              activeColor: Theme.of(context).primaryColor,
              trackColor: Colors.grey.shade600,
              value: index == 1
                  ? notificationSwitch
                  : index == 2
                      ? appNotificationSwitch
                      : index == 3,
              onChanged: (value) {
                setState(() {
                  index == 1
                      ? notificationSwitch = !notificationSwitch
                      : index == 2
                          ? appNotificationSwitch = !appNotificationSwitch
                          : index == 3;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget arrowTile({String? name, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              name!,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            ),
            trailing: IconButton(
                onPressed: onPressed,
                padding: const EdgeInsets.only(left: 40),
                icon: Icon(Icons.arrow_forward_ios,
                    size: 15, color: Colors.grey.shade400))),
      ),
    );
  }
}
