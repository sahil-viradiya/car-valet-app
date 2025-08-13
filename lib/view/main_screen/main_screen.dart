import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wallet_parking/resources/color_code.dart';

import '../../controller/main_controller.dart';
import '../../router/routs_names.dart';
import '../../utils/images.dart';
import '../../utils/static_data.dart';


class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorCode.appBGColor,
        body: Navigator(key: Get.nestedKey(controller.navigationId), initialRoute: RoutsNames.home, onGenerateRoute: controller.onGenerateRoute),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Obx(()=> BottomNavigationBar(
            backgroundColor: ColorCode.white,
                elevation: 2,
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                selectedLabelStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                selectedItemColor: ColorCode.black,
                selectedIconTheme: const IconThemeData(color: ColorCode.black),
                currentIndex: StaticData.selectedIndex.value,
                onTap: (value) {
                  controller.selectScreen(value,context);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StaticData.selectedIndex.value == 0
                            ? Images.ticketOutlined
                            : Images.ticket,
                      ),
                      label: "All Tickets"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StaticData.selectedIndex.value == 1
                            ? Images.homeOutlined
                            : Images.home,
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StaticData.selectedIndex.value == 2
                            ? Images.profileOutlined
                            : Images.profile,
                      ),
                      label: "Profile")
                ]),
          ),
        ));
  }
}
