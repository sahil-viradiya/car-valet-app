import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_parking/controller/adding_new_controller.dart';

import 'package:wallet_parking/resources/color_code.dart';
import 'package:wallet_parking/resources/custum_textfield.dart';
import 'package:wallet_parking/router/routs_names.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/confirm_screen/confirm_screen.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/widgets/required_text.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/widgets/text_with_divider.dart';

import '../../../resources/tables_keys_values.dart';
import '../../../utils/static_data.dart';
import '../../../utils/validation_utils.dart';

class EditScreen extends GetView<AddingNewTicketController> {
  static route() => MaterialPageRoute(
        builder: (context) => const EditScreen(),
      );
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QueryDocumentSnapshot ticketItem = Get.arguments;
    controller.colorIndex.value = ticketItem[keyVehicleColor];

    return Obx(() => Scaffold(
      backgroundColor: ColorCode.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                if (controller.isSaved.value)
                  InkWell(
                      onTap: () {
                        if(controller.isSaved.value){
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.arrow_back)),
                const Text(
                  "  Edit Details",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorCode.black),
                ),
              ],
            ),
          ),
          body: controller.isSaved.value
              ? const ConfirmScreen()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/yellow_circle.png"),
                            SizedBox(
                              // height: 40,
                              width: 150,
                              child: DottedLine(
                                direction: Axis.horizontal,
                                lineThickness: 1.0,
                                dashLength: 10.0,
                                dashColor: Colors.grey.shade300,
                                dashGapLength: 10.0,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ColorCode.kYellow, width: 1)),
                            )
                          ],
                        ),
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
                        height: 40,
                      ),
                      textWithDivider(
                        text: "Vehicle Owner Details",
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredText(
                              text: "Owner Name",
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller: controller.ownerNameController,
                              validator: (value) => emptyNotAllow(
                                  value: value,
                                  errorMessage: "Please enter a owner name"),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const RequiredText(
                              text: "Whatsapp Number",
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller: controller.whatsAppNumberController,
                              validator: (value) => emptyNotAllow(
                                  value: value,
                                  errorMessage:
                                      "Please enter a your whatsapp number"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textWithDivider(
                        text: "Vehicle Details",
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredText(
                              text: "Vehicle Plate Number",
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller:
                                  controller.vehiclePlateNumberController,
                              validator: (value) => emptyNotAllow(
                                  value: value,
                                  errorMessage:
                                      "Please enter vehicle plate number"),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text("Vehicle Company    ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorCode.klightBlcktext,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 8,
                            ),
                            Obx(() => Theme(
                              data: Theme.of(context).copyWith(
                                  focusColor: ColorCode.buttonClryellow,
                                  highlightColor: ColorCode.buttonClryellow,
                                  hoverColor: ColorCode.buttonClryellow
                              ),
                              child: DropdownButtonFormField(
                                value: controller.selectedVehicleCompany.value == 'N/A'
                                    ? null : controller.selectedVehicleCompany.value,
                                hint: const Text('Select'),
                                isExpanded: true,
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                //isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                style: const TextStyle(
                                    fontFamily: "Inter",
                                    height: 1,
                                    //fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: ColorCode.textColorblack),
                                validator: (value) => emptyNotAllow(
                                    value: value,
                                    errorMessage: "Please select vehicle company"),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    )
                                ),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    controller.selectedVehicleCompany.value = newValue;
                                  }
                                },
                                items: StaticData.vehicleCompanyList.map((value) {
                                  return DropdownMenuItem(
                                    value: value.name,
                                    child:  Text(value.name,
                                      style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          color: ColorCode.textColorblack),
                                    ),

                                    // Row(
                                    //   spacing: 5,
                                    //   children: [
                                    //     // Image.network(
                                    //     //   value.logoUrl,
                                    //     //   width: 50,
                                    //     //   height: 50,
                                    //     //   fit: BoxFit.contain,
                                    //     //   errorBuilder: (context, error, stackTrace) {
                                    //     //     return const Icon(Icons.error, size: 24);
                                    //     //   },
                                    //     // ),
                                    //     // const SizedBox(width: 5),
                                    //     Text(value.name,
                                    //       style: const TextStyle(
                                    //           fontFamily: "Inter",
                                    //           //fontWeight: FontWeight.w400,
                                    //           fontSize: 14,
                                    //           color: AppColors.textColorblack),
                                    //     ),
                                    //   ],
                                    // )
                                  );
                                }).toList(),
                              ),
                            )),
                            // CustomTextField(
                            //   controller: controller.vehicleCompanyController,
                            //   validator: (value) => emptyNotAllow(
                            //       value: value,
                            //       errorMessage: "Please enter vehicle Company"),
                            // ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text("Vehicle Model    ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorCode.klightBlcktext,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller: controller.vehicleModelController,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text("Color Of Vehicle  ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorCode.klightBlcktext,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 80,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: StaticData.vehicleColors
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    // final color = entry.value;
                                    bool isSelected =
                                        controller.colorIndex.value == index;
                                    return GestureDetector(
                                      onTap: () {
                                        controller.colorIndex.value = index;
                                        debugPrint(
                                            "Color : ${controller.colorIndex.value = index}");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          height: isSelected ? 60 : 50,
                                          width: isSelected ? 60 : 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                StaticData.vehicleColors[index],
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  controller.colorIndex.value ==
                                                          index
                                                      ? Colors.yellow
                                                      : Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   "This will change status as key collected",
                  //   style: TextStyle(
                  //       fontFamily: "Inter",
                  //       fontSize: 12,
                  //       color: Colors.grey.shade600,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {


                      controller.isSaved.value=true;

                      if (controller.saveButtonText.value == "Save") {

                        controller.saveButtonText.value = "Confirm";

                      } else if (controller.saveButtonText.value == "Confirm") {
                        Get.offAllNamed(RoutsNames.main);
                      }
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
                          controller.saveButtonText.value,
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
        ));
  }
}
