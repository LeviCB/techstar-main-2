import 'package:flutter/material.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/models/message.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Container(
            decoration:
                DesignConfig.boxDecorationContainer(Colors.transparent, 10),
            margin: const EdgeInsets.only(bottom: 4, top: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              leading: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    child: DesignConfig.displayCourseImage(
                        'https://celebritybiobook.com/wp-content/uploads/2021/09/Yash-8.jpg',
                        25,
                        ''),
                  ),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        // messageList[index].name!,
                        "username",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 5),
                      Text(
                        // messageList[index].subTitle!,
                        "user bio",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorRes.greyColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 100 * .75,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: ColorRes.greyColor,
                          //color: Theme.of(context).primaryColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            height: .14,
            width: double.infinity,
            color: ColorRes.greyColor,
          ),
        )
      ],
    );
  }
}
