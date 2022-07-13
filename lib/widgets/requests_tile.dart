import 'package:flutter/material.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/models/request.dart';

class RequestsTile extends StatefulWidget {
  final Request request;
  const RequestsTile({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestsTile> createState() => _RequestsTileState();
}

class _RequestsTileState extends State<RequestsTile> {
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
              contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
              leading: Stack(
                children: <Widget>[
                  DesignConfig.displayCourseImage(
                      StringRes.baseImageUrl + widget.request.profileImage,
                      22.5,
                      ''),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.request.username,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.request.bio,
                        style: const TextStyle(
                          fontSize: 13,
                          color: ColorRes.greyColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                          child: Text( 
                            "Confirm",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.greyColor),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
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
    );
  }
}
