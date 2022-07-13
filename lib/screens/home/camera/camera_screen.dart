// ignore_for_file: unused_field, use_key_in_widget_constructors

import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late void _initializeControllerFuture;
  bool _isReady = false;
  bool _isRecording = false;
  DateTime recordingStart = DateTime.now();
  double maxzoom = 0;
  double minzoom = 0;
  double curzoom = 0;

  @override
  void initState() {
    super.initState();
    _setUpCamera();
  }

  void _setUpCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.ultraHigh,
      );
      _initializeControllerFuture = await _controller.initialize();
      _controller.setFlashMode(FlashMode.always);
      maxzoom = await _controller.getMaxZoomLevel();
      minzoom = await _controller.getMinZoomLevel();
      curzoom = await _controller.getMinZoomLevel();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  bool flashOn = true;
  bool frontCamera = false;
  Offset dragUpdateOffset = const Offset(0, 0);

  endVideo() async {
    setState(() {
      curzoom = minzoom;
      _isRecording = false;
    });
    final video = await _controller.stopVideoRecording();
    _controller.setZoomLevel(minzoom);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayVideoScreen(
          videoPath: video.path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isRecording) {
      if (DateTime.now().difference(recordingStart).inSeconds > 15) {
        endVideo();
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: getFooter(),
      body: getBody(),
    );
  }

  Widget cameraPreview() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    if (_isReady == false || !_controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: size.width,
        height: size.height,
        child: const Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: ClipRRect(
          child: cameraPreview(),
        ),
      ),
    );
  }

  Widget getBodyBK() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white),
      child: const Image(
        image: NetworkImage(
          "https://images.unsplash.com/photo-1582152629442-4a864303fb96?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2VsZmllfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget getFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Icons.person,
                      color: Colors.yellow,
                      size: 23,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 23,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // GestureDetector(
                          //   onTap: () async {
                          //     if (frontCamera) {
                          //       _controller = CameraController(
                          //         _cameras[0],
                          //         ResolutionPreset.ultraHigh,
                          //       );
                          //       _initializeControllerFuture =
                          //           await _controller.initialize();
                          //       frontCamera = !frontCamera;
                          //     } else {
                          //       _controller = CameraController(
                          //         _cameras[1],
                          //         ResolutionPreset.ultraHigh,
                          //       );
                          //       _initializeControllerFuture =
                          //           await _controller.initialize();
                          //       frontCamera = !frontCamera;
                          //     }
                          //     maxzoom = await _controller.getMaxZoomLevel();
                          //     minzoom = await _controller.getMinZoomLevel();
                          //     curzoom = await _controller.getMinZoomLevel();
                          //     setState(() {});
                          //   },
                          //   child: const Icon(
                          //     Icons.cameraswitch_outlined,
                          //     color: Colors.white,
                          //     size: 25,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (flashOn) {
                                _controller.setFlashMode(FlashMode.off);
                              } else {
                                _controller.setFlashMode(FlashMode.always);
                              }
                              setState(() {
                                flashOn = !flashOn;
                              });
                            },
                            child: Icon(
                              flashOn ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Icon(
                            Icons.play_circle_outline_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 25,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onLongPressMoveUpdate: (details) {
                  var diff = dragUpdateOffset - details.localPosition;
                  if (diff.direction > 1) {
                    if (curzoom < 7.9) {
                      setState(() {
                        curzoom += 0.1;
                      });
                      _controller.setZoomLevel(curzoom);
                    } else {
                      _controller.setZoomLevel(maxzoom);
                    }
                  } else if (diff.direction < -1) {
                    if (curzoom > 1.1) {
                      setState(() {
                        curzoom -= 0.1;
                      });
                      _controller.setZoomLevel(curzoom);
                    } else {
                      _controller.setZoomLevel(minzoom);
                    }
                  }
                  setState(() {
                    dragUpdateOffset = details.localPosition;
                  });
                },
                onLongPressStart: (details) {
                  setState(() {
                    dragUpdateOffset = details.localPosition;
                  });
                },
                onLongPress: () async {
                  await _controller.startVideoRecording();
                  setState(() {
                    _isRecording = true;
                    recordingStart = DateTime.now();
                  });
                },
                onLongPressEnd: (_) async {
                  var video = await _controller.stopVideoRecording();
                  MediaInfo? mediaInfo = await VideoCompress.compressVideo(
                      video.path,
                      quality: VideoQuality.LowQuality);
                  _controller.setZoomLevel(minzoom);
                  setState(
                    () {
                      curzoom = minzoom;
                      _isRecording = false;
                    },
                  );
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayVideoScreen(
                        videoPath: mediaInfo!.file!.path,
                      ),
                    ),
                  );
                  // final video = await _controller.stopVideoRecording();
                  // _controller.setZoomLevel(minzoom);
                  // setState(() {
                  //   curzoom = minzoom;
                  //   _isRecording = false;
                  // });
                  // await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => DisplayVideoScreen(
                  //       videoPath: video.path,
                  //     ),
                  //   ),
                  // );
                },
                onTap: () async {
                  try {
                    var image = await _controller.takePicture();
                    var imageBytes = await image.readAsBytes();
                    var path = (await getApplicationSupportDirectory())
                            .toString()
                            .replaceAll("Directory: ", "")
                            .replaceAll("'", "") +
                        "/" +
                        image.name;
                    image =
                        XFile((await FlutterImageCompress.compressAndGetFile(
                      image.path,
                      path,
                      quality: 75,
                      minWidth: 500,
                      minHeight: 500,
                    ))!
                            .path);
                    imageBytes = await image.readAsBytes();
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          imagePath: imageBytes,
                          imagePathMain: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    // 
                  }
                },
                child: _isRecording
                    ? CircularPercentIndicator(
                        animation: true,
                        animationDuration: 15000,
                        addAutomaticKeepAlive: false,
                        radius: 60,
                        animateFromLastPercent: true,
                        progressColor: Colors.red,
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: (1 /
                                    15000000 *
                                    (DateTime.now().difference(recordingStart))
                                        .inMicroseconds >
                                1)
                            ? 1
                            : 1 /
                                15000000 *
                                (DateTime.now().difference(recordingStart))
                                    .inMicroseconds,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 3.5, color: Colors.white)),
                      ),
              ),
              const SizedBox(
                width: 15,
              ),

              IconButton(
                onPressed: () async {
                  if (frontCamera) {
                    _controller = CameraController(
                      _cameras[0],
                      ResolutionPreset.ultraHigh,
                    );
                    _initializeControllerFuture =
                        await _controller.initialize();
                    frontCamera = !frontCamera;
                  } else {
                    _controller = CameraController(
                      _cameras[1],
                      ResolutionPreset.ultraHigh,
                    );
                    _initializeControllerFuture =
                        await _controller.initialize();
                    frontCamera = !frontCamera;
                  }
                  maxzoom = await _controller.getMaxZoomLevel();
                  minzoom = await _controller.getMinZoomLevel();
                  curzoom = await _controller.getMinZoomLevel();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.cameraswitch_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              // const IconButton(
              //   onPressed: null,
              //   icon: Icon(
              //     Icons.emoji_emotions_sharp,
              //     color: Colors.white,
              //     size: 28,
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final Uint8List imagePath;
  final String imagePathMain;

  const DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.imagePathMain,
  }) : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  int currIndex = 0;
  static final myFilters = [
    const ColorFilter.mode(Colors.transparent, BlendMode.dst),
    const ColorFilter.mode(Colors.teal, BlendMode.softLight),
    const ColorFilter.mode(Colors.teal, BlendMode.hardLight),
    const ColorFilter.mode(Colors.deepPurple, BlendMode.hue),
    // sepia
    const ColorFilter.matrix([
      0.393,
      0.769,
      0.189,
      0,
      0,
      0.349,
      0.686,
      0.168,
      0,
      0,
      0.272,
      0.534,
      0.131,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]),
    // greyscale
    const ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]),
    // invert
    const ColorFilter.matrix([
      -1,
      0,
      0,
      0,
      255,
      0,
      -1,
      0,
      0,
      255,
      0,
      0,
      -1,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ]),
    const ColorFilter.linearToSrgbGamma(),
    const ColorFilter.srgbToLinearGamma(),
    const ColorFilter.mode(Colors.transparent, BlendMode.dst),
  ];
  Offset dragStart = const Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0.0).isNegative) {
                if (currIndex == 0) {
                  currIndex = myFilters.length - 1;
                } else {
                  currIndex -= 1;
                }
              } else {
                if (currIndex == myFilters.length - 1) {
                  currIndex = 0;
                } else {
                  currIndex += 1;
                }
              }
              setState(() {});
            },
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ColorFiltered(
                colorFilter: myFilters[currIndex],
                child: Image.memory(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 55),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.3)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, bottom: 25),
                    child: Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayVideoScreen extends StatefulWidget {
  final String videoPath;

  const DisplayVideoScreen({Key? key, required this.videoPath})
      : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.file(
      File(widget.videoPath),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
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
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(
        children: [
          GestureDetector(
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
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: VideoPlayer(_controller)),
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 55),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.3)),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 23,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 25, bottom: 25),
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 60,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
