import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_parking/resources/tables_keys_values.dart';

import '../firebase/firebase_api.dart';
import '../model/default_response.dart';

class TicketController extends GetxController{
  final FirebaseApi firebaseApi = FirebaseApi();
  RxList<QueryDocumentSnapshot> tickets = <QueryDocumentSnapshot>[].obs;

  List<QueryDocumentSnapshot> allTickets = [];
  RxBool isLoading = true.obs;

  Future<void> fetchTickets({bool isRefresh = false}) async {
    isLoading.value = true;
  if(isRefresh){
    allTickets.clear();
  }
    if (allTickets.isEmpty) {
      DefaultResponse response = await firebaseApi.getTicketsFromFirebase();
      if (response.status == true) {
        List<QueryDocumentSnapshot> fetchedTickets = response.responseData;

        // Sort tickets with "Exit request" at the top
        fetchedTickets.sort((a, b) {
          String statusA = a['status'];
          String statusB = b['status'];
          if (statusA == "Exit request" && statusB != "Exit request") {
            return -1;
          } else if (statusA != "Exit request" && statusB == "Exit request") {
            return 1;
          } else {
            DateTime createdAtA = DateTime.fromMillisecondsSinceEpoch(a[keyCreatedAt]);
            DateTime createdAtB = DateTime.fromMillisecondsSinceEpoch(b[keyCreatedAt]);
            return createdAtB.compareTo(createdAtA);
          }
        });

        allTickets.addAll(fetchedTickets);
        debugPrint("All tickets: ${response.responseData.length}");
      } else {
        debugPrint("Error fetching tickets: ${response.message}");
      }
    }
    isLoading.value = false;
  }
  @override
  void onInit() {
    super.onInit();
    fetchTickets();

  }
}