import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:wallet_parking/resources/color_code.dart';
import 'package:wallet_parking/router/routs_names.dart';
import 'package:wallet_parking/utils/get_storage_manager.dart';
import 'package:wallet_parking/utils/images.dart';

import 'package:wallet_parking/view/home_screen/ticket_item_view.dart';

import '../../controller/home_controller.dart';
import '../../controller/ticket_controller.dart';
import '../../resources/tables_keys_values.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.appBGColor,
      appBar: AppBar(
        backgroundColor: ColorCode.white,
        automaticallyImplyLeading: false,
        title: Text(
          " Hello,${GetStorageManager.getValue(prefName, "")}",
          style: const TextStyle(
              fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }
        return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchTickets(isRefresh: true);
              Get.find<TicketController>().fetchTickets(isRefresh: true);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.currentIndex.value = 0;
                            controller.update();
                          },
                          child: Chip(
                            side: BorderSide(
                                color: controller.currentIndex.value == 0
                                    ? Colors.transparent
                                    : ColorCode.mainColor.withOpacity(0.3)),
                            labelStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: controller.currentIndex.value == 0
                                    ? ColorCode.kbuttonTextClr
                                    : ColorCode.mainColor),
                            color: WidgetStatePropertyAll(
                              controller.currentIndex.value == 0
                                  ? ColorCode.selectedIndexColor
                                  : Colors.transparent,
                            ),
                            padding: EdgeInsets.zero,
                            label: Text(
                                "Exit Request(${controller.exitedRequestCount.value})"),
                          ),
                        ),
                        GestureDetector(
                          // splashColor: Colors.transparent,
                          onTap: () {
                            if (controller.parkedCount.value == 0) {
                            } else {
                              controller.currentIndex.value = 1;
                              controller.update();
                            }
                          },
                          child: Chip(
                            side: BorderSide(
                                color: controller.currentIndex.value == 1
                                    ? Colors.transparent
                                    : ColorCode.mainColor.withOpacity(0.3)),
                            labelStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: controller.currentIndex.value == 1
                                    ? ColorCode.kbuttonTextClr
                                    : ColorCode.mainColor),
                            color: WidgetStatePropertyAll(
                              controller.currentIndex.value == 1
                                  ? ColorCode.selectedIndexColor
                                  : Colors.transparent,
                            ),
                            padding: EdgeInsets.zero,
                            label:
                                Text("Parked(${controller.parkedCount.value})"),
                          ),
                        ),
                        GestureDetector(
                          // splashColor: Colors.transparent,
                          onTap: () {
                            if (controller.keyReturnedCount.value == 0) {
                            } else {
                              controller.currentIndex.value = 2;
                              controller.update();
                            }
                          },
                          child: Chip(
                            side: BorderSide(
                                color: controller.currentIndex.value == 2
                                    ? Colors.transparent
                                    : ColorCode.mainColor.withOpacity(0.3)),
                            labelStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: controller.currentIndex.value == 2
                                    ? ColorCode.kbuttonTextClr
                                    : ColorCode.mainColor),
                            color: WidgetStatePropertyAll(
                              controller.currentIndex.value == 2
                                  ? ColorCode.selectedIndexColor
                                  : Colors.transparent,
                            ),
                            padding: EdgeInsets.zero,
                            label: Text(
                                "Key Returned(${controller.keyReturnedCount.value})"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: controller.exitedRequestCount.value == 0 &&
                              controller.currentIndex.value == 0
                          ? ListView(
                            children: [
                              Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     const SizedBox(height: 100,),
                                      SvgPicture.asset(
                                        Images
                                            .noTicketCarImg, // Replace with your image path
                                        width: 200,
                                        height: 200,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "No new Requests",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF7D7D7D),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        width: 220,
                                        child: Text(
                                          "When owner request for exit, it will appear here",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF7D7D7D),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 100),
                              itemCount: controller.tickets.length,
                              itemBuilder: (context, index) {
                                var ticketItem = controller.tickets[index];
                                if (controller.currentIndex.value == 0 &&
                                    (ticketItem[keyStatus] == 'Exit request' || ticketItem[keyStatus] == 'Exit processing')) {
                                  if (ticketItem[keyStatus] == 'Exit request') {
                                    return ExitTicketView(
                                      ticketItem: ticketItem,
                                    );
                                  } else {
                                    return TicketItemView(
                                        ticketItem: ticketItem);
                                  }
                                } else if (controller.currentIndex.value == 1 &&
                                    ticketItem[keyStatus] == 'Parked') {
                                  return TicketItemView(ticketItem: ticketItem);
                                } else if (controller.currentIndex.value == 2 &&
                                    ticketItem[keyStatus] == 'Key returned') {
                                  return TicketItemView(ticketItem: ticketItem);
                                }
                                return const SizedBox();
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: SizedBox(
          height: 75,
          width: 75,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: ColorCode.kYellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180)),
            onPressed: () {
              Get.toNamed(RoutsNames.addingNew);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Images.newTicketCarIcon),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    " + New",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
