import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/change_password_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/mixins/validation_mixin.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = "/change_password";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with InputValidationMixin {
  ChangePasswordScreenController controller =
      Get.put(ChangePasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: GetX(
          builder: (ChangePasswordScreenController controller) {
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
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
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
                                return null;
                              } else {
                                return "Please enter a valid current password.";
                              }
                            },
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
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
                              hintText: "Current Password",
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
                                if (isPasswordSame(
                                    password ?? '',
                                    controller
                                        .confirmNewPasswordController.text)) {
                                  return null;
                                } else {
                                  return "New password and confirm password must be same.";
                                }
                              } else {
                                return "Please enter a valid new password.";
                              }
                            },
                            controller: controller.newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.isNewPasswordVisible.value,
                            decoration: InputDecoration(
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
                              hintText: "New Password",
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
                                    !controller.isNewPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorRes.greyColor,
                                  ),
                                  onPressed: () {
                                    controller.isNewPasswordVisible.value =
                                        !controller.isNewPasswordVisible.value;
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
                                    controller.newPasswordController.text)) {
                                  return null;
                                } else {
                                  return "New password and confirm password must be same.";
                                }
                              } else {
                                return "Please enter a valid confirm password.";
                              }
                            },
                            controller: controller.confirmNewPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                !controller.isConfirmNewPasswordVisible.value,
                            decoration: InputDecoration(
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
                              hintText: "Confirm Password",
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
                                    !controller
                                            .isConfirmNewPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorRes.greyColor,
                                  ),
                                  onPressed: () {
                                    controller
                                            .isConfirmNewPasswordVisible.value =
                                        !controller
                                            .isConfirmNewPasswordVisible.value;
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                          controller.changePassword();
                        },
                        child: Text(
                          'Change Password',
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