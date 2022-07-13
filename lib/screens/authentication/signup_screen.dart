import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/signup_screen_controller.dart';
import 'package:techstar/helper/color_res.dart';
import 'package:techstar/mixins/validation_mixin.dart';
import 'package:techstar/screens/authentication/login_screen.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with InputValidationMixin {
  SignupScreenController controller = Get.put(SignupScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: GetX(
          builder: (SignupScreenController controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CustomLoadingIndicator(
                  size: size.width / 100 * 17.5,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: controller.formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Create Account",
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
                          "Please fill the input blow here.",
                          style: TextStyle(
                            color: ColorRes.greyColor,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (username) {
                            if (isUsernameValid(username ?? '')) {
                              return null;
                            } else {
                              return "Please enter a valid name.";
                            }
                          },
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintStyle: TextStyle(
                              color: ColorRes.greyColor,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.person,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (username) {
                            if (isUsernameValid(username ?? '')) {
                              return null;
                            } else {
                              return "Please enter a valid username.";
                            }
                          },
                          controller: controller.usernameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Username",
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintStyle: TextStyle(
                              color: ColorRes.greyColor,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.person,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (phone) {
                            if (isPhoneNumberValid(phone ?? '')) {
                              return null;
                            } else {
                              return "Please enter a valid phone number.";
                            }
                          },
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "Phone",
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintStyle: TextStyle(
                              color: ColorRes.greyColor,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.phone_android,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (email) {
                            if (isEmailValid(email ?? '')) {
                              return null;
                            } else {
                              return 'Please enter a valid email address.';
                            }
                          },
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "Email",
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.red),
                            ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (password) {
                            if (isPasswordValid(password ?? '')) {
                              if (isPasswordSame(password ?? '', controller.confirmPasswordController.text)) {
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
                              borderSide: BorderSide(color: ColorRes.greyColor),
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
                              if (isPasswordSame(password ?? '', controller.passwordController.text)) {
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
                              borderSide: BorderSide(color: ColorRes.greyColor),
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
                              controller.signup();
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed(LoginScreen.routeName);
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorRes.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

