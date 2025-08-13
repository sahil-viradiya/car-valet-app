import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet_parking/utils/utils_methods.dart';

import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';
import '../utils/get_storage_manager.dart';


class FirebaseApi  {
  late FirebaseFirestore fireStore;

  FirebaseApi() {
    fireStore = FirebaseFirestore.instance;
  }

  Future<DefaultResponse> defaultAdminCreate() async {
    DefaultResponse defaultResponse = DefaultResponse();
    QuerySnapshot query = await fireStore.collection(tableUser).where(keyUserRole, isEqualTo: userRoleAdmin).get();
    if (query.docs.isNotEmpty) {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = "Admin Already Exist";
      return defaultResponse;
    }

    Map<String, dynamic> bodyMap = <String, dynamic>{
      keyEmail: "admin@gmail.com",
      keyPassword: "admin123",
      keyGender: "male",
      keyName: "Admin".firstCapitalize(),
      keyCountryCode: "91",
      keyPhone: "9876543210",
      keyDateOfBirth: getCurrentDateTime(),
      keyAddress: "Ahmedabad",
      keyCity: "Ahmedabad",
      keyState: "Gujarat",
      keyZipCode: "382481",
      keyCountry: "India",
      keyProfile: "",
      keyAccountStatus: accountAllowed,
      keyUserRole: userRoleAdmin,
      keyCreatedAt: getCurrentDateTime()
    };

    // Map<String, dynamic> bodyMap = <String, dynamic>{
    //   keyEmail: "driver@gmail.com",
    //   keyPassword: "123456",
    //   keyGender: "male",
    //   keyName: "Driver".firstCapitalize(),
    //   keyCountryCode: "91",
    //   keyPhone: "9876012345",
    //   keyDateOfBirth: getCurrentDateTime(),
    //   keyAddress: "Ahmedabad",
    //   keyCity: "Ahmedabad",
    //   keyState: "Gujarat",
    //   keyZipCode: "382481",
    //   keyCountry: "India",
    //   keyProfile: "",
    //   keyAccountStatus: accountAllowed,
    //   keyUserRole: userRoleDrive,
    //   keyCreatedAt: getCurrentDateTime()
    // };
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: "admin@gmail.com",
      password: "admin123",
    );
    final User? user = FirebaseAuth.instance.currentUser;
    var uid = user!.uid;

    await FirebaseFirestore.instance.collection(tableUser).doc(uid).set(bodyMap).whenComplete(() async {
      defaultResponse.statusCode = onSuccess;
      defaultResponse.status = true;
      defaultResponse.message = "Admin Register Successfully";
    }).catchError((e) {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    });
    return defaultResponse;
  }


  Future<DefaultResponse> loginUserFirebase({required String email, required String password}) async {
    DefaultResponse defaultResponse = DefaultResponse();
    QuerySnapshot querySnapshot = await fireStore.collection(tableUser).where(keyEmail, isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty &&
        querySnapshot.docs[0].get(keyEmail) == email &&
        querySnapshot.docs[0].get(keyPassword) == password) {
      if (querySnapshot.docs[0].get(keyAccountStatus) == accountBlocked) {
        defaultResponse.statusCode = onFailed;
        defaultResponse.status = false;
        defaultResponse.message = "Your account is blocked. Please contact Admin";
      } else {
        defaultResponse.statusCode = onSuccess;
        defaultResponse.status = true;
        defaultResponse.message = "User Login Successfully";
        defaultResponse.responseData = querySnapshot.docs[0];
      }
    } else {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = "Please enter valid email and password";
    }
    return defaultResponse;
  }

  Future<DefaultResponse> getLoggedInDriverDetails() async {
    DefaultResponse defaultResponse = DefaultResponse();
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await fireStore.collection(tableUser).doc(user.uid).get();

        if (documentSnapshot.exists) {
          defaultResponse.statusCode = 200;
          defaultResponse.status = true;
          defaultResponse.responseData = documentSnapshot.data();
        } else {
          defaultResponse.statusCode = 404;
          defaultResponse.status = false;
          defaultResponse.message = "Driver not found";
        }
      } catch (e) {
        defaultResponse.statusCode = 500;
        defaultResponse.status = false;
        defaultResponse.message = e.toString();
      }
    } else {
      defaultResponse.statusCode = 401;
      defaultResponse.status = false;
      defaultResponse.message = "User not logged in";
    }

    return defaultResponse;
  }

  Future<DefaultResponse> addTicket({
    required String plateNumber,
    required String vehicleModel,
    required String company,
    required String owner,
    required String parkingSlot,
    required String whatsAppNumber,
    required int colorIndex,
  }) async {
    DefaultResponse defaultResponse = DefaultResponse();
    QuerySnapshot querySnapshot = await fireStore.collection(tableTicket)
        .orderBy(keyCreatedAt, descending: true)
        .limit(1)
        .get();
    int ticketNumber = 1;
    if(querySnapshot.size > 0){
      ticketNumber = querySnapshot.docs.first[keyTicketNumber] + 1;
    }
    Map<String, dynamic> bodyMap = <String, dynamic>{
      keyTicketNumber: ticketNumber,
      keySlotName: parkingSlot,
      keyWhatsAppNumber: whatsAppNumber,
      keyVehiclePlateNumber: plateNumber,
      keyVehicleModel: vehicleModel,
      keyVehicleCompany: company,
      keyOwnerName: owner,
      keyVehicleColor: colorIndex,
      keyStatus: "Key collected",
      keyName: GetStorageManager.getValue(prefName, ""),
      keyCreatedAt: getCurrentDateTime(),
      keyCreatedBy: GetStorageManager.getValue(prefUserId, ""),
    };

    await fireStore.collection(tableTicket).add(bodyMap).then((doc) {
      defaultResponse.statusCode = onSuccess;
      defaultResponse.status = true;
      defaultResponse.message = "Ticket added successfully";
      defaultResponse.responseData = doc.id;
    }).catchError((e) {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    });

    return defaultResponse;
  }

  Future<DefaultResponse> getTicketsFromFirebase() async {
    DefaultResponse defaultResponse = DefaultResponse();

    try {
      QuerySnapshot querySnapshot = await fireStore.collection(tableTicket).get(); // Assuming your tickets are stored in a collection named "tableTicket"
      defaultResponse.statusCode = 200;
      defaultResponse.status = true;
      defaultResponse.responseData = querySnapshot.docs;
    } catch (e) {
      defaultResponse.statusCode = 500;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    }

    return defaultResponse;
  }

  Future<DefaultResponse> updateTicket({
    required String docId,
    required String whatsAppNumber,
    required String parkingSlot,
    required String plateNumber,
    required String vehicleModel,
    required String company,
    required String owner,
    required int colorIndex,
    required String status,
  }) async {

    DefaultResponse defaultResponse = DefaultResponse();
    Map<String, dynamic> bodyMap = <String, dynamic>{
      keySlotName: parkingSlot,
      keyStatus: status,
      keyWhatsAppNumber: whatsAppNumber,
      keyVehiclePlateNumber: plateNumber,
      keyVehicleModel: vehicleModel,
      keyVehicleCompany: company,
      keyOwnerName: owner,
      keyVehicleColor: colorIndex,
    };
       await fireStore.collection(tableTicket).doc(docId).set(bodyMap, SetOptions(merge: true)).then((doc) {
      defaultResponse.statusCode = onSuccess;
      defaultResponse.status = true;
      defaultResponse.message = "Ticket updated successfully";
    }).catchError((e) {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    });
    return defaultResponse;
  }
  Future<DefaultResponse> updateTicketStatus({
    required DocumentSnapshot ticketDoc,
    required String status,
  }) async {

    DefaultResponse defaultResponse = DefaultResponse();
    Map<String, dynamic> bodyMap = <String, dynamic>{};
    if(status == "Key returned"){
      bodyMap = <String, dynamic>{
        keyStatus: status,
        keyCreatedAt : getCurrentDateTime()
      };
    } else{
      bodyMap = <String, dynamic>{
        keyStatus: status,
      };
    }

      await fireStore.collection(tableTicket).doc(ticketDoc.id).set(bodyMap, SetOptions(merge: true)).then((doc) {
      defaultResponse.statusCode = onSuccess;
      defaultResponse.status = true;
      defaultResponse.message = "Ticket status updated successfully";
    }).catchError((e) {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    });

    return defaultResponse;
  }

  Future<DefaultResponse> getParkingSlot() async {
    DefaultResponse defaultResponse = DefaultResponse();

    try {
      QuerySnapshot querySnapshot = await fireStore.collection(tableParkingSlots).get();
      defaultResponse.statusCode = 200;
      defaultResponse.status = true;
      defaultResponse.responseData = querySnapshot.docs;
    } catch (e) {
      defaultResponse.statusCode = 500;
      defaultResponse.status = false;
      defaultResponse.message = e.toString();
    }

    return defaultResponse;
  }

}
