import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallet_parking/controller/home_controller.dart';
import 'package:wallet_parking/controller/ticket_controller.dart';

import 'package:wallet_parking/utils/network_client.dart' show DioExceptions;
import 'package:dio/dio.dart' as dio;
import '../firebase/firebase_api.dart';
import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';
import '../router/routs_names.dart';
import '../utils/api_client.dart';
import '../utils/app_snackbar.dart';
import '../utils/show_progress_dialog.dart';
import '../utils/static_data.dart';

class ExitRequestController extends GetxController {
  final progressDialog = ShowProgressDialog();
  final FirebaseApi firebaseApi = FirebaseApi();
  RxString buttonText = "Accept".obs;
  RxBool isLoading = false.obs;

  updateTicket(DocumentSnapshot ticketDoc, BuildContext context) {
    if (ticketDoc[keyStatus] == "Exit request") {
      buttonText.value = "Accept";
      updateTicketStatus(ticketDoc, "Exit processing", context);
    }else if(ticketDoc[keyStatus] == "Exit processing"){
      buttonText.value = "key returned";
      updateTicketStatus(ticketDoc, "Key returned", context);
    }
  }

  Future<void> updateTicketStatus(
      DocumentSnapshot ticketDoc, String status,BuildContext context) async {
    progressDialog.show();
    DefaultResponse defaultResponse = await firebaseApi.updateTicketStatus(
        ticketDoc: ticketDoc, status: status);
    progressDialog.hide();
    if (defaultResponse.status == true) {
      // callSendWhatsappMessage(ownerMobileNumber: ticketDoc[keyWhatsAppNumber].toString());
      if(Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchTickets(isRefresh: true);
        if(status == "Key returned"){
          Get.find<HomeController>().currentIndex.value = 2;
          Get.find<HomeController>().update();
        }
      }
      if(Get.isRegistered<TicketController>()) {
        Get.find<TicketController>().fetchTickets(isRefresh: true);
      }
      if(status == "Key returned" || status == "Exit processing"){
        Get.back(result: true);
      } else {
        Get.back();
      }
      AppSnackBar.success(message: defaultResponse.message);
    } else {
      AppSnackBar.error(message: defaultResponse.message);
    }
  }

  Future<void> callSendWhatsappMessage({required String ownerMobileNumber}) async {
    isLoading(true);
    try {
      final String cleanedNumber = ownerMobileNumber.trim().replaceAll(RegExp(r'\D'), '');
      if (cleanedNumber.length != 10) {     // Validate that the number is exactly 10 digits
        AppSnackBar.error(message: "Invalid phone number. It must be exactly 10 digits.");
      }
      final response = await dioClient.post(
        ApiConstant.sendWhatsappMessage,
        data: {
          "toNumber": "+91$cleanedNumber",
        },
      );

      if (response['code'] == 200) {
        if (kDebugMode) {
          print('response====> ${response['data']['message']}');
        }
        // if(response['data'] != null){
        //   AppSnackBar.success(message: response['data']['message']);
        // } else{
        //   AppSnackBar.error(message: "Something went wrong...");
        // }
      }
    } on dio.DioException catch (e) {
      if (kDebugMode) {
        print("Status Code: ${e.response?.statusMessage}");
        print('Error: $e');
      }
      DioExceptions.showErrorMessage(
        Get.context!,
        DioExceptions.fromDioError(
          dioError: e,
          errorFrom: "Send Whatsapp Message",
        ).errorMessage(),
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint("SendWhatsappMessage Error => ${e.toString()}");
      }
    } finally {
      isLoading(false);
    }
  }
}
