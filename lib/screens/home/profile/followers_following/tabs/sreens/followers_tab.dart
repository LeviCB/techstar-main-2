import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/screens/home/profile/followers_following/tabs/controllers/followers_tab_controller.dart';

class FollowersTab extends StatefulWidget {
  const FollowersTab({
    Key? key,
  }) : super(key: key);

  @override
  State<FollowersTab> createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
  FollowersTabController controller = Get.put(FollowersTabController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetX(builder: (FollowersTabController controller) {
      if (controller.isConnected.value) {}
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  //cursorHeight: 19,
                  cursorWidth: 2,
                  //enabled: true,
                  style: const TextStyle(color: ColorRes.white, fontSize: 18),
                  cursorColor: ColorRes.greyColor,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.white)),
                    focusColor: ColorRes.white,
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorRes.greyColor, width: 0.8)), //
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: ColorRes.greyColor)),
                    //border: InputBorder.none,
                    prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
                          child: Icon(
                            Icons.search,
                            color: ColorRes.greyColor,
                            size: 25,
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Container(
                            decoration: DesignConfig.boxDecorationContainer(
                                Colors.transparent, 10),
                            margin: const EdgeInsets.only(bottom: 4, top: 4),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(5, 10, 5, 5),
                              leading: Stack(
                                children: <Widget>[
                                  DesignConfig.displayCourseImage(
                                      'https://celebritybiobook.com/wp-content/uploads/2021/09/Yash-8.jpg',
                                      22.5,
                                      ''),
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text(
                                        // messageList[index].name!,
                                        "username",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        // messageList[index].subTitle!,
                                        "user bio",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: ColorRes.greyColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ColorRes.greyColor),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(11, 6, 11, 6),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              //onTap: () {},
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 0, right: 0),
                        //   child: Container(
                        //     height: .14,
                        //     width: double.infinity,
                        //     color: ColorRes.greyColor,
                        //   ),
                        // )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
