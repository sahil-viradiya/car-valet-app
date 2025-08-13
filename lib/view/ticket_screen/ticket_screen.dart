

import 'package:flutter/material.dart';


import 'package:get/get.dart';

import 'package:wallet_parking/controller/ticket_controller.dart';
import 'package:wallet_parking/resources/color_code.dart';

import 'package:wallet_parking/view/home_screen/ticket_item_view.dart';

import '../../controller/home_controller.dart';
import '../../resources/tables_keys_values.dart';

class TicketScreen extends GetView<TicketController> {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketController controller = Get.find<TicketController>();

    return Scaffold(
      backgroundColor: ColorCode.appBGColor,
      appBar: AppBar(
        backgroundColor: ColorCode.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Tickets",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            color: ColorCode.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body:Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
              onRefresh: () async {
            await controller.fetchTickets(isRefresh: true);
            Get.find<HomeController>().fetchTickets(isRefresh: true);

          },child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: controller.allTickets.length,
              itemBuilder: (context, index) {
                var ticket = controller.allTickets[index];
                if (ticket[keyStatus] == "Exit request") {
                  return ExitTicketView(ticketItem: ticket);
                } else {
                  return TicketItemView(ticketItem: ticket);
                }
              },
            ),
          ) );
        }
      }),


    );
  }

}

