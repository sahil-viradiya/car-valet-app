import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/firebase_api.dart';
import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';

class HomeController extends GetxController{
  RxInt currentIndex = 0.obs;

  final FirebaseApi firebaseApi = FirebaseApi();
  RxBool isLoading = true.obs;
  var exitedRequestCount = 0.obs;
  var parkedCount = 0.obs;
  var keyReturnedCount = 0.obs;
  RxList<QueryDocumentSnapshot> tickets = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  Future<void> fetchTickets({bool isRefresh = false}) async {
    isLoading.value = true;
    if (isRefresh) {
      tickets.clear();
    }

    if (tickets.isEmpty) {
      DefaultResponse response = await firebaseApi.getTicketsFromFirebase();
      if (response.status == true) {
        List<QueryDocumentSnapshot> fetchedTickets = response.responseData;
        tickets.clear();
        tickets.addAll(fetchedTickets);
      } else {
        debugPrint("Error fetching tickets: ${response.message}");
      }
    }
    tickets.sort((a, b) => b[keyCreatedAt].compareTo(a[keyCreatedAt]));
    var parked = 0;
    var exited = 0;
    var keyReturn = 0;
    for (var listItem in tickets) {
        if(listItem[keyStatus] == 'Parked'){
          parked++;
        }else if(listItem[keyStatus] == 'Exit request' || listItem[keyStatus] == 'Exit processing'){
          exited++;
        }else if(listItem[keyStatus] == 'Key returned'){
          keyReturn++;
        }
    }
    exitedRequestCount.value = exited;
    parkedCount.value = parked;
    keyReturnedCount.value = keyReturn;
    isLoading.value = false;
  }


}