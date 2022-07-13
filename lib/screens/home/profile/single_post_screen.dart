import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';

class SinglePostScreen extends StatefulWidget {
  
  static String routeName = '/single_post';
  const SinglePostScreen({Key? key}) : super(key: key);

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(title: const Text("Post")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  decoration: DesignConfig.boxDecorationContainer(
                      Colors.transparent, 10),
                  margin: const EdgeInsets.only(bottom: 4, top: 4),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    leading: Stack(
                      children: <Widget>[
                        DesignConfig.displayCourseImage(
                          'https://celebritybiobook.com/wp-content/uploads/2021/09/Yash-8.jpg',
                          25,
                          '',
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
                                "User Name",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Subtitle",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.greyColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://www.lovesove.com/wp-content/uploads/2021/06/Kgf-Dialogue-Dp-Lovesove.jpg'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.favorite_border_outlined,
                                  color: ColorRes.white,
                                  size: 23.5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Like',
                                  style: TextStyle(
                                    color: ColorRes.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  FeatherIcons.messageSquare,
                                  color: ColorRes.white,
                                  size: 22.5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Comment',
                                  style: TextStyle(
                                    color: ColorRes.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  FeatherIcons.share2,
                                  color: ColorRes.white,
                                  size: 22.5,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(
                                    color: ColorRes.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "123 Likes",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "12 Jan 2022",
                          style: TextStyle(
                              color: ColorRes.greyColor, fontSize: 12),
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                        //width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Carmen Myers",
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Excellent !",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                    color: ColorRes.greyColor,
                                    fontSize: 15,
                                    height: 1.3),
                                   
                              ),
                            )
                          ],
                        )),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 0, right: 0),
                  //   child: Container(
                  //     height: 3,
                  //     width: double.infinity,
                  //     color: ColorRes.greyColor,
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ));
  }
}
