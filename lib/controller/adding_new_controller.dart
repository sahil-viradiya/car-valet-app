import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_parking/utils/network_client.dart' show DioExceptions;
import 'package:dio/dio.dart' as dio;
import 'package:wallet_parking/controller/home_controller.dart';
import 'package:wallet_parking/controller/ticket_controller.dart';

import '../firebase/firebase_api.dart';
import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';
import '../utils/api_client.dart';
import '../utils/app_snackbar.dart';
import '../utils/show_progress_dialog.dart';
import '../utils/utils_methods.dart';

class AddingNewTicketController extends GetxController {
  final FirebaseApi firebaseApi = FirebaseApi();
  RxBool isLoading = false.obs;

  //controllers
  final TextEditingController ownerNameController = TextEditingController();
  // final TextEditingController vehicleCompanyController =
  //     TextEditingController();
  final TextEditingController whatsAppNumberController =
      TextEditingController();
  final TextEditingController vehiclePlateNumberController =
      TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final RxString selectedVehicleCompany = 'N/A'.obs;
  final progressDialog = ShowProgressDialog();
  RxInt colorIndex = 0.obs;
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  //for retrieving data
  RxList<QueryDocumentSnapshot> parkingSlotList = <QueryDocumentSnapshot>[].obs;
  RxList<String> parkingSlotStringList = <String>[].obs;

  RxBool isConfirmed = false.obs;
  RxBool isSaved = false.obs;
  RxString buttonText = "Key Collected".obs;
  RxString saveButtonText = "Save".obs;

  bool dropDownEnabled = false;
  String docId = "";

  RxString selectedValue = 'Select'.obs;

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    ownerNameController.dispose();
    whatsAppNumberController.dispose();
    vehiclePlateNumberController.dispose();
    vehicleModelController.dispose();
   // vehicleCompanyController.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getParkingSlot();
    var data = Get.arguments;
    if (data != null) {
      QueryDocumentSnapshot ticketDoc = data;
      docId = ticketDoc.id;

      ownerNameController.text =
          getDocumentValue(documentSnapshot: ticketDoc, key: keyOwnerName);
      selectedVehicleCompany.value =
          getDocumentValue(documentSnapshot: ticketDoc, key: keyVehicleCompany);
      vehiclePlateNumberController.text = getDocumentValue(
          documentSnapshot: ticketDoc, key: keyVehiclePlateNumber);
      vehicleModelController.text =
          getDocumentValue(documentSnapshot: ticketDoc, key: keyVehicleModel);
      whatsAppNumberController.text =
          getDocumentValue(documentSnapshot: ticketDoc, key: keyWhatsAppNumber);
      colorIndex.value = getDocumentValue(documentSnapshot: ticketDoc, key: keyVehicleColor);
      buttonText.value = "Confirm";
      isConfirmed.value = true;
    }
  }

  validateForm(context) {
    if (formStateKey.currentState!.validate()) {
      debugPrint("addDriver : Validation done");
      buttonText.value = "Confirm";
      isConfirmed.value = true;
      if (docId.isEmpty) {
        addNewTicket();
      }
    }
  }

  void updateStatus(context) {
    if (selectedValue.value == 'Select') {
      progressDialog.show();
      AppSnackBar.warning(message: "You didn't selected any Parking Slot.\nAdd it on the All Ticket Screen when you parked the vehicle.");
      Future.delayed(const Duration(seconds: 3),(){
        progressDialog.hide();
        updateTicket(context, docId, 'Key collected');
      });
     // AppSnackBar.warning(message: "You didn't selected any Parking Slot. Add it on the All Ticket Screen when you parked the vehicle");
    } else if (docId.isNotEmpty) {
      updateTicket(context, docId, 'Parked');
    } else {
      AppSnackBar.error(message: "Ticket not created. Please try again");

    }
  }

  Future<void> addNewTicket() async {
    if (formStateKey.currentState!.validate()) {
      progressDialog.show();
      DefaultResponse defaultResponse = await firebaseApi.addTicket(
        parkingSlot: selectedValue.value,
        plateNumber: vehiclePlateNumberController.text.trim(),
        vehicleModel: vehicleModelController.text.trim(),
        company: selectedVehicleCompany.value.trim(),
        owner: ownerNameController.text.trim(),
        whatsAppNumber: whatsAppNumberController.text.trim(),
        colorIndex: colorIndex.value,
      );
      progressDialog.hide();
      if (defaultResponse.status == true) {
        docId = defaultResponse.responseData;
        // callSendWhatsappMessage(ownerMobileNumber: whatsAppNumberController.text.trim());
        try {
          Get.find<HomeController>().fetchTickets(isRefresh: true);
          Get.find<TicketController>().fetchTickets(isRefresh: true);
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        AppSnackBar.error(message: defaultResponse.message);
      }
    }
  }

  Future<void> getParkingSlot() async {
    DefaultResponse response = await firebaseApi.getParkingSlot();
    if (response.status == true) {
      List<QueryDocumentSnapshot> docList = response.responseData;
      parkingSlotList.clear();
      parkingSlotStringList.clear();
      parkingSlotList.addAll(docList);
      for (var slot in parkingSlotList) {
        parkingSlotStringList.add(slot[keySlotName]);
      }
    } else {
      debugPrint("Error getParkingSlot: ${response.message}");
    }
  }

  Future<void> updateTicket(
      BuildContext context, String docId, String status) async {
    if (formStateKey.currentState!.validate()) {
      progressDialog.show();
      DefaultResponse defaultResponse = await firebaseApi.updateTicket(
          docId: docId,
          status: status,
          parkingSlot: selectedValue.value,
          plateNumber: vehiclePlateNumberController.text.trim(),
          vehicleModel: vehicleModelController.text.trim(),
          company: selectedVehicleCompany.value.trim(),
          owner: ownerNameController.text.trim(),
          whatsAppNumber: whatsAppNumberController.text.trim(),
          colorIndex: colorIndex.value);
      progressDialog.hide();
      if (defaultResponse.status == true) {
        AppSnackBar.success(message: defaultResponse.message);
        // callSendWhatsappMessage(ownerMobileNumber: whatsAppNumberController.text.trim());
        try {
          Get.find<HomeController>().fetchTickets(isRefresh: true);
          Get.find<TicketController>().fetchTickets(isRefresh: true);
        } catch (e) {
          debugPrint(e.toString());
        }
        Navigator.pop(context);
      } else {
        AppSnackBar.error(message: defaultResponse.message);
      }
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
