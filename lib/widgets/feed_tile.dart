import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/helper/design_config.dart';
import 'package:techstar/helper/string_res.dart';
import 'package:techstar/models/post.dart';
import 'package:techstar/screens/home/feeds/comments_screen.dart';
import 'package:techstar/screens/home/feeds/tabs/controllers/friends_tab_controller.dart';
import 'package:techstar/screens/home/feeds/tabs/controllers/trending_tab_controller.dart';
import 'package:techstar/widgets/wave_dots_loading_indicator.dart';
import 'package:video_player/video_player.dart';

class FeedTile extends StatefulWidget {
  const FeedTile({
    required this.index,
    required this.post,
    required this.size,
    required this.friendsTabController,
    required this.trendingTabController,
    Key? key,
  }) : super(key: key);

  final Size size;
  final Post post;
  final FriendsTabController? friendsTabController;
  final TrendingTabController? trendingTabController;
  final int index;

  @override
  State<FeedTile> createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
  @override
  Widget build(BuildContext context) {
    return widget.post.image != ""
        ? ImageFeedTile(
            size: widget.size,
            post: widget.post,
            friendsTabController: widget.friendsTabController,
            trendingTabController: widget.trendingTabController,
            index: widget.index,
          )
        : widget.post.video != ""
            ? VideoFeedTile(
                size: widget.size,
                post: widget.post,
                friendsTabController: widget.friendsTabController,
                trendingTabController: widget.trendingTabController,
                index: widget.index,
              )
            : TextFeedTile(
                size: widget.size,
                post: widget.post,
                friendsTabController: widget.friendsTabController,
                trendingTabController: widget.trendingTabController,
                index: widget.index,
              );
  }
}

class TextFeedTile extends StatefulWidget {
  const TextFeedTile({
    Key? key,
    required this.post,
    required this.size,
    required this.friendsTabController,
    required this.trendingTabController,
    required this.index,
  }) : super(key: key);

  final Size size;
  final Post post;
  final FriendsTabController? friendsTabController;
  final TrendingTabController? trendingTabController;
  final int index;

  @override
  State<TextFeedTile> createState() => _TextFeedTileState();
}

class _TextFeedTileState extends State<TextFeedTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeedAccountTile(post: widget.post),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.post.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.3,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        LikeShareCommentTile(
          post: widget.post,
          friendsTabController: widget.friendsTabController,
          trendingTabController: widget.trendingTabController,
          index: widget.index,
        ),
      ],
    );
  }
}

class ImageFeedTile extends StatefulWidget {
  const ImageFeedTile(
      {Key? key,
      required this.post,
      required this.size,
      required this.friendsTabController,
      required this.trendingTabController,
      required this.index})
      : super(key: key);

  final Size size;
  final Post post;
  final FriendsTabController? friendsTabController;
  final TrendingTabController? trendingTabController;
  final int index;

  @override
  State<ImageFeedTile> createState() => _ImageFeedTileState();
}

class _ImageFeedTileState extends State<ImageFeedTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FeedAccountTile(post: widget.post),
        GestureDetector(
          onDoubleTap: () {
            if (widget.post.islike) {
              if (widget.friendsTabController == null) {
                widget.trendingTabController!.unlikePost(widget.index);
              } else {
                widget.friendsTabController!.unlikePost(widget.index);
              }
            } else {
              if (widget.friendsTabController == null) {
                widget.trendingTabController!.likePost(widget.index);
              } else {
                widget.friendsTabController!.likePost(widget.index);
              }
            }
            setState(() {});
          },
          child: Stack(
            children: [
              SizedBox(
                height: widget.size.width,
                width: widget.size.width,
                child: const Align(
                  alignment: Alignment.center,
                  child: WaveDotsLoadingIndicator(
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: widget.size.width,
                width: widget.size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      StringRes.baseImageUrl + widget.post.image,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        LikeShareCommentTile(
          index: widget.index,
          post: widget.post,
          friendsTabController: widget.friendsTabController,
          trendingTabController: widget.trendingTabController,
        ),
      ],
    );
  }
}

class LikeShareCommentTile extends StatefulWidget {
  const LikeShareCommentTile(
      {Key? key,
      required this.post,
      required this.friendsTabController,
      required this.trendingTabController,
      required this.index})
      : super(key: key);
  final Post post;
  final FriendsTabController? friendsTabController;
  final TrendingTabController? trendingTabController;
  final int index;

  @override
  State<LikeShareCommentTile> createState() => _LikeShareCommentTileState();
}

class _LikeShareCommentTileState extends State<LikeShareCommentTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.post.islike) {
                      if (widget.friendsTabController == null) {
                        widget.trendingTabController!.unlikePost(widget.index);
                      } else {
                        widget.friendsTabController!.unlikePost(widget.index);
                      }
                    } else {
                      if (widget.friendsTabController == null) {
                        widget.trendingTabController!.likePost(widget.index);
                      } else {
                        widget.friendsTabController!.likePost(widget.index);
                      }
                    }
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.post.islike
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: ColorRes.white,
                              size: 23.5,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
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
                  onTap: () {
                    Get.toNamed(
                      CommentsScreen.routeName,
                      arguments: {
                        "post": widget.post,
                      },
                    );
                  },
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
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            height: 3,
            width: double.infinity,
            color: ColorRes.greyColor,
          ),
        )
      ],
    );
  }
}

class FeedAccountTile extends StatelessWidget {
  const FeedAccountTile({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Container(
        decoration: DesignConfig.boxDecorationContainer(Colors.transparent, 10),
        margin: const EdgeInsets.only(bottom: 4, top: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          leading: Stack(
            children: <Widget>[
              DesignConfig.displayCourseImage(
                StringRes.baseImageUrl + post.profileImage,
                22.5,
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
                  children: <Widget>[
                    Text(
                      post.username,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Visibility(
                      visible: post.description != "",
                      child: Column(
                        children: const [
                          SizedBox(height: 5),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 13,
                              color: ColorRes.greyColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class VideoFeedTile extends StatefulWidget {
  const VideoFeedTile(
      {Key? key,
      required this.post,
      required this.size,
      required this.friendsTabController,
      required this.trendingTabController,
      required this.index})
      : super(key: key);

  final Size size;
  final Post post;
  final FriendsTabController? friendsTabController;
  final TrendingTabController? trendingTabController;
  final int index;

  @override
  State<VideoFeedTile> createState() => _VideoFeedTileState();
}

class _VideoFeedTileState extends State<VideoFeedTile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.contentUri(
        Uri.parse(StringRes.baseImageUrl + widget.post.video));
    _controller.setLooping(true);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  DateTime tappedOn = DateTime.now();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeedAccountTile(post: widget.post),
        SizedBox(
          height: widget.size.width,
          child: Stack(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  if (widget.post.islike) {
                    if (widget.friendsTabController == null) {
                      widget.trendingTabController!.unlikePost(widget.index);
                    } else {
                      widget.friendsTabController!.unlikePost(widget.index);
                    }
                  } else {
                    if (widget.friendsTabController == null) {
                      widget.trendingTabController!.likePost(widget.index);
                    } else {
                      widget.friendsTabController!.likePost(widget.index);
                    }
                  }
                  setState(() {});
                },
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                  setState(() {
                    _isVisible = true;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      _isVisible = false;
                    });
                  });
                },
                child: Center(
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              _controller.value.isBuffering
                  ? CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Theme.of(context).primaryColor,
                    )
                  : Visibility(
                      visible: (!_controller.value.isBuffering && _isVisible) ||
                          !_controller.value.isPlaying,
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 50,
                          ),
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                            setState(() {
                              _isVisible = true;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                _isVisible = false;
                              });
                            });
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        LikeShareCommentTile(
          index: widget.index,
          post: widget.post,
          friendsTabController: widget.friendsTabController,
          trendingTabController: widget.trendingTabController,
        ),
      ],
    );
  }
}
