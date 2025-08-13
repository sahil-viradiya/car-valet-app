import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/firebase_api.dart';
import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';
import '../router/routs_names.dart';
import '../utils/app_snackbar.dart';
import '../utils/get_storage_manager.dart';
import '../utils/show_progress_dialog.dart';
import '../utils/utils_methods.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final invalidCredentials = false.obs;
  final isPasswordObscured = true.obs; // Add this line
  final progressDialog = ShowProgressDialog();
  final firebaseApi = FirebaseApi();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  RxBool isShow = true.obs;

  void onxReady() {
    super.onReady();
  }

  Future<void> signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty) {
      emailError.value = 'Enter an email';
      return;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email';
      return;
    } else {
      emailError.value = '';
    }

    if (password.isEmpty) {
      passwordError.value = 'Enter a password';
      return;
    } else if (password.length < 6) {
      passwordError.value = 'Enter a password 6+ chars long';
      return;
    } else {
      passwordError.value = '';
    }

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      progressDialog.show();
      DefaultResponse defaultResponse = await firebaseApi.loginUserFirebase(email: email, password: password);
      if (defaultResponse.status == false) {
        progressDialog.hide();
        AppSnackBar.error(message: defaultResponse.message);
        return;
      } else if (defaultResponse.responseData[keyUserRole] != userRoleDrive) {
        progressDialog.hide();
        AppSnackBar.error(message: "You can't login in this App");
        return;
      }

      User? currentUser;
      FirebaseAuth.instance.signInWithEmailAndPassword(email: defaultResponse.responseData[keyEmail], password: password).then((auth) {
        currentUser = auth.user;
        progressDialog.hide();
        GetStorageManager.setValue(prefIsLogin, true);
        GetStorageManager.setValue(prefProfile, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyProfile));
        GetStorageManager.setValue(prefName, defaultResponse.responseData[keyName]);
        GetStorageManager.setValue(prefPhone, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyPhone));
        GetStorageManager.setValue(prefEmail, defaultResponse.responseData[keyEmail]);
        GetStorageManager.setValue(prefPassword, defaultResponse.responseData[keyPassword]);
        GetStorageManager.setValue(prefAddress, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyAddress));
        GetStorageManager.setValue(prefCity, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyCity));
        GetStorageManager.setValue(prefState, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyState));
        GetStorageManager.setValue(prefLicenceNumber, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyLicenceNumber));
        GetStorageManager.setValue(prefLicenceExp, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyLicenceExp));
        GetStorageManager.setValue(prefUserRole, defaultResponse.responseData[keyUserRole]);
        if (defaultResponse.responseData[keyUserRole] != userRoleAdmin) {
          GetStorageManager.setValue(prefCreatedBy, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyCreatedBy));
        }
        GetStorageManager.setValue(prefAccountStatus, defaultResponse.responseData[keyAccountStatus]);
        GetStorageManager.setValue(prefCreatedAt, getDocumentValue(documentSnapshot: defaultResponse.responseData, key: keyCreatedAt));
        GetStorageManager.setValue(prefUserId, (defaultResponse.responseData as DocumentSnapshot).id);

        // AppSnackBar.success(message: defaultResponse.message);
        Get.offAllNamed(RoutsNames.main);
      }).catchError((error) {
        progressDialog.hide();
        debugPrint('error.message!${error.message}');
        AppSnackBar.error(message: error.message);
      });
    } else {
      progressDialog.hide();
      AppSnackBar.error(message: "Something want to wrong. Please try again");
    }
  }

  Future<void> handleLogin() async {}

  void togglePasswordVisibility() {
    // Add this method
    isPasswordObscured.value = !isPasswordObscured.value;
  }
}
