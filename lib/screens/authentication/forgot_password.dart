import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/forgot_password_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgot_password";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordScreenController controller =
      Get.put(ForgotPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: GetX(
          builder: (ForgotPasswordScreenController controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Text(
                      "Forget Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please enter email to continue.",
                      style: TextStyle(
                        color: ColorRes.greyColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      readOnly: controller.otpSended.value,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: ColorRes.greyColor,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.email,
                            color: ColorRes.greyColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: ColorRes.greyColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      cursorColor: Colors.white,
                      cursorHeight: 22.5,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Visibility(
                      visible: controller.otpSended.value,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.otpController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              hintText: "OTP",
                              hintStyle: TextStyle(
                                color: ColorRes.greyColor,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.key,
                                  color: ColorRes.greyColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: ColorRes.greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            cursorColor: Colors.white,
                            cursorHeight: 22.5,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          fixedSize: const Size(400, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                         controller.otpSended.value ? controller.verifyOtp() : controller.sendOtp();
                        },
                        child: Text(
                          controller.otpSended.value ? "Verify OTP" : 'Send OTP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
