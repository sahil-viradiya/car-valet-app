import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_parking/view/home_screen/home_screen.dart';
import 'package:wallet_parking/view/profile_screen/profile_screen.dart';
import 'package:wallet_parking/view/ticket_screen/ticket_screen.dart';

import '../router/routs_names.dart';
import '../utils/static_data.dart';
import 'controller_bindings.dart';

class MainController extends GetxController {
  var navigationId = Random().nextInt(100000);
  final pages = <String>[RoutsNames.ticket, RoutsNames.home, RoutsNames.profile];

  void selectScreen(int index, BuildContext context) {
    if(StaticData.selectedIndex.value != StaticData.selectedPreIndex.value){
      StaticData.selectedPreIndex.value = StaticData.selectedIndex.value;
    }
    StaticData.selectedIndex.value = index;
    Get.toNamed(pages[index], id: navigationId)?.then((value){
      if(value == true){
        StaticData.selectedIndex.value = StaticData.selectedPreIndex.value;
      }
    });
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RoutsNames.ticket) {
      return GetPageRoute(
        settings: settings,
        page: () => const TicketScreen(),
        binding: TicketControllerBinding(),
        transition: Transition.noTransition,
      );
    }else if (settings.name == RoutsNames.home) {
      return GetPageRoute(
        settings: settings,
        page: () =>  const HomeScreen(),
        binding: HomeControllerBinding(),
        transition: Transition.noTransition,
      );
    }else if (settings.name == RoutsNames.profile) {
      return GetPageRoute(
        settings: settings,
        page: () => const ProfileScreen(),
        binding: ProfileControllerBinding(),
        transition: Transition.noTransition,
      );
    }
    return null;
  }

}
