import 'package:flutter/material.dart';
import 'package:techstar/controllers/comments_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/models/comment.dart';

class CommentTile extends StatefulWidget {
  const CommentTile({
    Key? key,
    required this.size,
    required this.comment,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final Size size;
  final Comment comment;
  final CommentsScreenController controller;
  final int index;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
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
                      StringRes.baseImageUrl + widget.comment.profileImage,
                      22.5,
                      ''),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.comment.username,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.comment.comment,
                          style: const TextStyle(
                            height: 1.2,
                            fontSize: 15,
                            color: ColorRes.greyColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.comment.likescount} ${widget.comment.likescount == "1" ? "Like" : "Likes"}',
                              style: const TextStyle(
                                color: ColorRes.greyColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                if (widget.comment.isLike) {
                                  widget.controller.unlikeComment(widget.index);
                                } else {
                                  widget.controller.likeComment(widget.index);
                                }
                                setState(() {});
                              },
                              child:widget.comment.isLike ?const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 18,
                              ) : const Icon(
                                Icons.favorite_outline,
                                color: ColorRes.greyColor,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
