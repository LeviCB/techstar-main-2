import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/reset_password_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/mixins/validation_mixin.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = "/reset_password";
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with InputValidationMixin {
  ResetPasswordScreenController controller =
      Get.put(ResetPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: GetX(
          builder: (ResetPasswordScreenController controller) {
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
                      "Reset Password",
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
                      "Please enter password to continue.",
                      style: TextStyle(
                        color: ColorRes.greyColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: controller.formGlobalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (password) {
                              if (isPasswordValid(password ?? '')) {
                                if (isPasswordSame(
                                    password ?? '',
                                    controller
                                        .confirmPasswordController.text)) {
                                  return null;
                                } else {
                                  return "Password and confirm password must be same";
                                }
                              } else {
                                return "Please enter a valid password.";
                              }
                            },
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: "Password",
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintStyle: const TextStyle(
                                color: ColorRes.greyColor,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.lock,
                                  color: ColorRes.greyColor,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7.5),
                                child: IconButton(
                                  icon: Icon(
                                    !controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorRes.greyColor,
                                  ),
                                  onPressed: () {
                                    controller.isPasswordVisible.value =
                                        !controller.isPasswordVisible.value;
                                  },
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: ColorRes.greyColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (password) {
                              if (isPasswordValid(password ?? '')) {
                                if (isPasswordSame(password ?? '',
                                    controller.passwordController.text)) {
                                  return null;
                                } else {
                                  return "Password and confirm password must be same";
                                }
                              } else {
                                return "Please enter a valid confirm password.";
                              }
                            },
                            controller: controller.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                !controller.isConfirmPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintStyle: const TextStyle(
                                color: ColorRes.greyColor,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.lock,
                                  color: ColorRes.greyColor,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7.5),
                                child: IconButton(
                                  icon: Icon(
                                    !controller.isConfirmPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorRes.greyColor,
                                  ),
                                  onPressed: () {
                                    controller.isConfirmPasswordVisible.value =
                                        !controller
                                            .isConfirmPasswordVisible.value;
                                  },
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: ColorRes.greyColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                          const SizedBox(
                            height: 35,
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
                          controller.resetPassword();
                        },
                        child: Text(
                          'Reset Password',
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
