// ignore_for_file: empty_catches

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/editprofile_screen_controller.dart';
import 'package:techstar/helper/string_res.dart';

class EditprofileScreen extends StatefulWidget {
  static String routeName = '/edit_profile';
  const EditprofileScreen({Key? key}) : super(key: key);

  @override
  _EditprofileScreenState createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  EditProfileScreenController controller =
      Get.put(EditProfileScreenController());
  File? image;


  profileImage(EditProfileScreenController controller) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: Stack(
        children: <Widget>[
          controller.image.value != ""
              ? controller.isImagePicked.value
                  ? Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: FileImage(image!), fit: BoxFit.cover),
                      ),
                    )
                  : Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(StringRes.baseImageUrl +
                                controller.image.value),
                            fit: BoxFit.cover),
                      ),
                    )
              : CircleAvatar(
                  radius: 65,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: const Icon(Icons.person, size: 100),
                  ),
                ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              height: 40,
              width: 40,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 18,
                ),
                onPressed: () async {
                  await (image = await controller.pickImage(image));
                  setState(() {},);
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setUserName() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: TextFormField(
        cursorColor: Theme.of(context).scaffoldBackgroundColor,
        keyboardType: TextInputType.text,
        controller: controller.usernameController,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            size: 22,
            color: Colors.grey.shade600,
          ),
          hintText: "Username",
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  setName() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: TextFormField(
        cursorColor: Theme.of(context).scaffoldBackgroundColor,
        keyboardType: TextInputType.text,
        controller: controller.nameController,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            size: 22,
            color: Colors.grey.shade600,
          ),
          hintText: "Name",
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  setBio() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: TextFormField(
        cursorColor: Theme.of(context).scaffoldBackgroundColor,
        keyboardType: TextInputType.text,
        controller: controller.bioController,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16,
            fontWeight: FontWeight.w400),
            minLines: 1,
        maxLines: 126,
        decoration: InputDecoration(
          hintText: "Bio",
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  setMobileNo() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Center(
        child: TextFormField(
          maxLength: 10,
          cursorColor: Theme.of(context).scaffoldBackgroundColor,
          keyboardType: TextInputType.number,
          controller: controller.phoneController,
          style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              size: 22,
              color: Colors.grey.shade600,
            ),
            counterText: "",
            hintText: "Phone",
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Center(
        child: TextFormField(
          readOnly: true,
          cursorColor: Theme.of(context).scaffoldBackgroundColor,
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailController,
          style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              size: 22,
              color: Colors.grey.shade600,
            ),
            hintText: "Email",
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Edit Profile",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetX(builder: (EditProfileScreenController controller) {
        return Form(
          key: controller.formGlobalKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  profileImage(controller),
                  const SizedBox(
                    height: 40,
                  ),
                  setEmail(),
                  const SizedBox(
                    height: 12,
                  ),
                  setUserName(),
                  const SizedBox(
                    height: 12,
                  ),
                  setName(),
                  const SizedBox(
                    height: 12,
                  ),
                  setMobileNo(),
                  const SizedBox(
                    height: 12,
                  ),
                  setBio(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          fixedSize: const Size(150, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (controller.isImagePicked.value) {
                            controller.editProfile(image);
                          } else {
                            controller.editProfile(null);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
