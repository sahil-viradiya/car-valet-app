import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void success({
    String title = "Success",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    // hide all custom snackbar
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message ?? nullMessage,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      maxWidth: getMaxWidth(),
    );
  }

  static void error({
    String title = "Error",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    // hide all custom snackbar
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message ?? nullMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      maxWidth: getMaxWidth(),
    );
  }

  static void warning({
    String title = "Warning",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    // hide all custom snackbar
    Get.closeAllSnackbars();
    Get.snackbar(
      duration:const Duration(seconds: 3),
      title,
      message ?? nullMessage,
      backgroundColor: Colors.yellow,
      colorText: Colors.white,
      maxWidth: getMaxWidth(),
    );
  }

  static void info({
    String title = "Info",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    // hide all custom snackbar
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message ?? nullMessage,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      maxWidth: getMaxWidth(),
    );
  }

  static double getMaxWidth(){
    return Get.width < 850 ? Get.width : Get.width / 2;
  }
}
