import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.width / 100 * 40,
              width: size.width / 100 * 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo_here.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
