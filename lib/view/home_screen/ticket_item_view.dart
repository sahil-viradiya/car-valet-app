import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wallet_parking/resources/tables_keys_values.dart';
import 'package:wallet_parking/utils/images.dart';
import 'package:wallet_parking/view/status_screen/status_screen.dart';

import '../../resources/color_code.dart';
import '../../router/routs_names.dart';
import '../../utils/static_data.dart';
import '../../utils/utils_methods.dart';


class TicketItemView extends StatelessWidget {
  final QueryDocumentSnapshot ticketItem;
  const TicketItemView({super.key, required this.ticketItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      InkWell(
        onTap: () {
          var status = ticketItem[keyStatus];
          if(status == 'Key collected'){
            Get.toNamed(RoutsNames.addingNew, arguments: ticketItem);
          }else if(status == 'Exit processing'){
            Get.toNamed(RoutsNames.exitView, arguments: ticketItem)?.then((value){
              if(value == true){
                if(StaticData.selectedIndex.value == 0){
                  Navigator.of(context).pop(true);
                }
              }
            });
          }else{
            var parked = ticketItem[keyStatus] == 'Parked';
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StatusScreen(isParked: parked ? true : false,ticketItem: ticketItem,);
            }));
          }

        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorCode.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: ticketItem[keyVehiclePlateNumber],
                              style: GoogleFonts.poppins()
                                  .copyWith(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight:
                                  FontWeight.w500)),
                          TextSpan(
                              text: "   #${ticketItem[keyTicketNumber]}",
                              style: GoogleFonts.poppins()
                                  .copyWith(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight:
                                  FontWeight.w500))
                        ])),
                    Container(
                      // height: 30,
                      // width: 100,
                      decoration: BoxDecoration(
                          color: ticketItem[keyStatus] == 'Key collected'
                              ? ColorCode.keyCollectedLight
                              : ticketItem[keyStatus] == 'Parked'
                              ? ColorCode.parkedLight :
                              ticketItem[keyStatus] == 'Exit request'
                              ? ColorCode.exitrequestLight
                              :ticketItem[keyStatus] == 'Exit processing'
                              ? ColorCode.exitProcessingLight
                              : ColorCode
                              .keyReturnedLight,
                          borderRadius:
                          BorderRadius.circular(8)),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Center(
                            child: Text(
                              ticketItem[keyStatus],
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  color: ticketItem[keyStatus] == 'Key collected'
                                      ? ColorCode.keyCollected
                                      : ticketItem[keyStatus] == 'Parked'
                                      ? ColorCode.parked :
                                        ticketItem[keyStatus] == 'Exit request'
                                      ? ColorCode.exitrequest
                                      :ticketItem[keyStatus] == 'Exit processing'
                                      ? ColorCode.exitProcessing
                                      : ColorCode
                                      .keyReturned,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticketItem[keyOwnerName],
                        style: GoogleFonts.poppins()
                            .copyWith(
                            fontSize: 12,
                            color: ColorCode.mainColor,
                            fontWeight:
                            FontWeight.w400)),
                    Text(getDatTimeString(ticketItem[keyCreatedAt]),
                        style: GoogleFonts.poppins()
                            .copyWith(
                            fontSize: 8,
                            color: ColorCode.mainColor,
                            fontWeight:
                            FontWeight.w400))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        makePhoneCall(ticketItem[keyWhatsAppNumber]);
                      },
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color:
                            Colors.grey.withOpacity(0.3),
                            spreadRadius: -6,
                            blurRadius: 4,
                            offset: const Offset(1, 3),
                          ),
                        ]),
                        child: SvgPicture.asset(
                            Images.phoneIcon),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        launchWhatsapp(ticketItem[keyWhatsAppNumber]);
                      },
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color:
                            Colors.grey.withOpacity(0.3),
                            spreadRadius: -6,
                            blurRadius: 4,
                            offset: const Offset(1, 3),
                          ),
                        ]),
                        child: SvgPicture.asset(
                            Images.whatsAppIcon),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ExitTicketView extends StatelessWidget {
  final QueryDocumentSnapshot ticketItem;
  const ExitTicketView({super.key, required this.ticketItem});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorCode.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:ticketItem[keyVehiclePlateNumber],
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "   #${ticketItem[keyTicketNumber]}",
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        ticketItem[keyOwnerName] ?? 'N/A',
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12,
                          color: ColorCode.mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              makePhoneCall(ticketItem[keyWhatsAppNumber]);

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: -6,
                                    blurRadius: 4,
                                    offset: const Offset(1, 3),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(Images.phoneIcon),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launchWhatsapp(ticketItem[keyWhatsAppNumber]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: -6,
                                    blurRadius: 4,
                                    offset: const Offset(1, 3),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(Images.whatsAppIcon),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorCode.exitrequestLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Center(
                            child: Text(
                              "Exit Request",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                color: ColorCode.exitrequest,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        getDatTimeString(ticketItem[keyCreatedAt]),
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 8,
                          color: ColorCode.mainColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutsNames.exitView, arguments:ticketItem);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorCode.exitnavigationClr,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        height: 135,
                        width: 36,
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorCode.kwhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
