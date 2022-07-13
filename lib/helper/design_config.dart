import 'package:flutter/material.dart';
import 'package:techstar/helper/color_res.dart';

class DesignConfig {
  static BoxDecoration boxDecorationBackground() {
    return const BoxDecoration(
      // ignore: prefer_const_literals_to_create_immutables
      gradient: LinearGradient(colors: [
        ColorRes.gradientTwo,
        ColorRes.gradientOne,
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
    );
  }

  static BoxDecoration boxDecorationButton(Color color1, Color color2) {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        color1,
        color2,
      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static BoxDecoration boxDecorationContainer(Color color, double radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration boxDecorationBorderButtonColor(
      Color color, double sizes) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(sizes),
        border: Border.all(color: color, width: 1));
  }

  static BoxDecoration boxDecorationButtonColor(
      Color color1, Color color2, double sizes) {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        color1,
        color2,
      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(sizes),
    );
  }

  static Widget displayCourseImage(String? image, double radius, String? hash) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: NetworkImage(image!),
    );
  }
}
