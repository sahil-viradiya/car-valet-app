import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_parking/controller/profile_controller.dart';
import 'package:wallet_parking/resources/color_code.dart';
import 'package:wallet_parking/resources/custum_clippath.dart';
import 'package:wallet_parking/utils/utils_methods.dart';

import '../../controller/main_controller.dart';
import '../../resources/tables_keys_values.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorCode.appBGColor,
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator()); // Loading indicator
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipPath(
                        clipper: CustumClipPath(),
                        child: Container(
                          height: height * 0.37,
                          color: Colors.yellow,
                          child: const Center(child: Text("ClipPath")),
                        ),
                      ),
                      ClipPath(
                        clipper: CustumClipPath(),
                        child: Container(
                          height: height * 0.36,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: customImageProvider(
                                  url: controller.driverData[keyProfile]),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/top-black_blurr.png",
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                       Positioned(
                        top: 20,
                        left: 15,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop(true);
                                },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: ColorCode.kwhite,
                              ),
                            ),
                            const Text(
                              " Profile",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  color: ColorCode.kwhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.driverData[keyName] ?? 'N/A',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorCode.black),
                  ),
                  Text(
                    controller.driverData[keyEmail] ?? 'N/A',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        color: ColorCode.mainColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.driverData[keyPhone] ?? 'N/A',
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        color: ColorCode.mainColor),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Address",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: ColorCode.mainColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  controller.driverData[keyAddress] ?? 'N/A',
                                  style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 15,
                                      color: ColorCode.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "State:",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          color: ColorCode.mainColor),
                                    ),
                                    Text(
                                      controller.driverData[keyState] ?? 'N/A',
                                      style: const TextStyle(
                                          fontFamily: "Inter",
                                          color: ColorCode.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "City:",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          color: ColorCode.mainColor),
                                    ),
                                    Text(
                                      controller.driverData[keyCity] ?? 'N/A',
                                      style: const TextStyle(
                                          fontFamily: "Inter",
                                          color: ColorCode.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200)),
                          // ignore: prefer_const_constructors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "License Details",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 10,
                                      color: ColorCode.mainColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "License Number:",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          color: ColorCode.mainColor),
                                    ),
                                    Text(
                                      controller.driverData[keyLicenceNumber] ??
                                          'N/A',
                                      style: const TextStyle(
                                          fontFamily: "Inter",
                                          color: ColorCode.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Licence Expiry Date:",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          color: ColorCode.mainColor),
                                    ),
                                    Text(
                                      controller.driverData[keyLicenceExp] ??
                                          'N/A',
                                      style:const TextStyle(
                                          fontFamily: "Inter",
                                          color: ColorCode.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              onTap: () {
                                logoutDialog();
                              },
                              child: const Text("Logout",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Colors.red,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
