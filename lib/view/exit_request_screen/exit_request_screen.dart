import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_parking/controller/exit_request_controller.dart';
import 'package:wallet_parking/resources/color_code.dart';
import 'package:wallet_parking/utils/images.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/confirm_screen/confirm_screen.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/widgets/text_with_divider.dart';

import '../../resources/tables_keys_values.dart';

import '../../router/routs_names.dart';
import '../../utils/static_data.dart';
import '../../utils/utils_methods.dart';

class ExitRequestScreen extends GetView<ExitRequestController> {
  const ExitRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot ticketItem = Get.arguments;
    return Scaffold(
      backgroundColor: ColorCode.appBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            Text(
              ticketItem[keyStatus] == "Exit processing"
                  ? "  Return Key"
                  : "  Exit Request",
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorCode.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(Images.parkedCar),
            const SizedBox(
              height: 15,
            ),
            Text(
              ticketItem[keySlotName] ?? 'N/A',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: ColorCode.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                // height: 371,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                  color: const Color.fromRGBO(254, 254, 245, 1),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Colors.yellow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ticket:${ticketItem[keyTicketNumber] ?? 'N/A'}",
                              style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  color: ColorCode.kbuttonTextClr,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticketItem[keyVehiclePlateNumber] ?? 'N/A',
                            style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                color: ColorCode.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color:
                                    ticketItem[keyStatus] == "Exit processing"
                                        ? ColorCode.keyCollectedLight
                                        : ColorCode.exitrequestLight,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Center(
                                  child: Text(
                                ticketItem[keyStatus],
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 12,
                                    color: ticketItem[keyStatus] ==
                                            "Exit processing"
                                        ? ColorCode.keyCollected
                                        : ColorCode.exitrequest,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(getDatTimeString(ticketItem[keyCreatedAt]),
                              style: GoogleFonts.poppins().copyWith(
                                  fontSize: 8,
                                  color: ColorCode.mainColor,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    textWithDivider(
                      text: " Customer Details",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DetailsTextRow(
                      title: 'Customer:',
                      text: ticketItem[keyOwnerName],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DetailsTextRow(
                      title: 'Whatsapp:',
                      text: ticketItem[keyWhatsAppNumber],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textWithDivider(
                      text: " Car Details",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DetailsTextRow(
                      title: 'Model:',
                      text: ticketItem[keyVehicleModel],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DetailsTextRow(
                      title: 'Company:',
                      text: ticketItem[keyVehicleCompany],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DetailsTextRow(
                        title: 'Color:',
                        text: StaticData
                            .vehicleColorsString[ticketItem[keyVehicleColor]]),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                ticketItem[keyStatus] == "Exit processing"
                    ? "This will change status as Key Returned"
                    : "This will change status as Exit Processing ",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  controller.updateTicket(ticketItem, context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    // right: 18,
                    // left: 18,
                  ),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        color: ColorCode.kYellow,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Text(
                      ticketItem[keyStatus] == "Exit processing"
                          ? "Key Returned"
                          : "Accept",
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorCode.kbuttonTextClr),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
