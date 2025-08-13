import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../firebase/firebase_api.dart';
import '../model/default_response.dart';

class ProfileController extends GetxController {
  final FirebaseApi firebaseApi = FirebaseApi();
  RxMap<String, dynamic> driverData = <String, dynamic>{}.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentDriverDetails();
  }

  Future<void> fetchCurrentDriverDetails() async {
    isLoading.value = true;
    DefaultResponse response = await firebaseApi.getLoggedInDriverDetails();
    if (response.status == true) {
      driverData.value = response.responseData; // Assuming responseData is a DocumentSnapshot
    } else {
      Get.snackbar("Error", "Failed to fetch driver details: ${response.message}");
    }
    isLoading.value = false;
  }
}
