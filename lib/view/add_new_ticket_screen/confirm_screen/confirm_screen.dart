import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_parking/controller/adding_new_controller.dart';
import 'package:wallet_parking/resources/color_code.dart';

import 'package:wallet_parking/view/add_new_ticket_screen/widgets/text_with_divider.dart';

import '../../../utils/static_data.dart';

class ConfirmScreen extends GetView<AddingNewTicketController> {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/yellow_tick.png"),
              Container(
                color: Colors.yellow,
                width: 132,
                height: 1,
              ),
              Image.asset("assets/images/yellow_circle.png"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Vehicle Info",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12,
                      color: ColorCode.black,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "Parking",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12,
                      color: ColorCode.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Summary",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                color: ColorCode.kbuttonTextClr,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              controller.buttonText.value = "Save";
                              controller.isConfirmed.value = false;
                              controller.isSaved.value = false;
                            },
                          )
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
                          controller.vehiclePlateNumberController.text,
                          style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: ColorCode.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorCode.keyCollectedLight,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Center(
                                child: Text(
                              "Key Collected",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  color: ColorCode.keyCollected,
                                  fontWeight: FontWeight.w400),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                    text: controller.ownerNameController.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DetailsTextRow(
                    title: 'Whatsapp:',
                    text: controller.whatsAppNumberController.text,
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
                    text: controller.vehicleModelController.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DetailsTextRow(
                    title: 'Company:',
                    text: controller.selectedVehicleCompany.value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DetailsTextRow(
                    title: 'Color:',
                    text: StaticData
                        .vehicleColorsString[controller.colorIndex.value],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Parking Slot",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () {
                _showBottomSheet(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.selectedValue.value,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            _showBottomSheet(context);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      itemCount: controller.parkingSlotStringList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedValue.value =
                                  controller.parkingSlotStringList[index];
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: controller.selectedValue.value ==
                                          controller.parkingSlotStringList[index]
                                      ? Colors.yellow
                                      : null,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8),
                                child: Text(
                                  controller.parkingSlotStringList[index]
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class DetailsTextRow extends StatelessWidget {
  const DetailsTextRow({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400),
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
