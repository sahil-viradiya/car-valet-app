import 'dart:math';

import 'package:flutter/material.dart';

/// ************************************ Firebase Storage ************************************************/
const folderUserProfile = 'user_profile';



/// ************************************ Firebase Table ************************************************/
const tableUser = 'users';
const tableTicket = 'tickets';
const tableParkingSlots = 'parking_slots';



/// ************************************ Firebase Keys ************************************************/

const keyEmail = 'email';
const keyPassword = 'password';
const keyNewPassword = 'new_password';
const keyConfirmPassword = 'confirm_password';
const keyRemember = 'remember';
const keyGender = 'gender';
const keyName = 'full_name';
const keyAddress = 'address';
const keyProfile = 'profile';
const keyCountryCode = 'country_Code';
const keyPhone = 'phone';
const keyDateOfBirth = 'date_of_birth';
const keyCity = 'city';
const keyState = 'state';
const keyZipCode = 'zip_code';
const keyCountry = 'country';
const keyUserRole = 'user_role';
const keyAccountStatus = 'account_status';
const keyCreatedAt = 'created_at';
const keyCreatedBy = 'created_by';
const keyLicenceNumber = 'licence_number';
const keyLicenceExp = 'licence_exp';
const keySlotName = 'slot_name';

const keyOwnerName = 'owner_name';
const keyWhatsAppNumber = 'whatsapp_number';
const keyVehiclePlateNumber = 'vehicle_plate_number';
const keyVehicleCompany = 'vehicle_company';
const keyVehicleModel = 'vehicle_model';
const keyTicketNumber = "ticket_number";
const keyVehicleColor = "vehicle_color";
const keyStatus = "status";
const keyTotalValets = "total_valets";

/// ************************************ Firebase Value ************************************************/

const userRoleAdmin = 'admin';
const userRoleDrive = 'driver';
const userRoleMember = 'member';
const userRoleGuest = 'guest';
const accountAllowed = 'allowed';
const accountBlocked = 'blocked';

/// ************************************ Shared-preference Keys ************************************************/

const prefIsLogin = "isLogin";
const prefFirebaseToken = "firebaseToken";
const prefEmail = 'email';
const prefPassword = 'password';
const prefRemember = 'remember';
const prefGender = 'gender';
const prefAge = 'age';
const prefName = 'full_name';
const prefCountryCode = 'countryCode';
const prefPhone = 'phone';
const prefDateOfBirth = 'date_of_birth';
const prefAddress = 'address';
const prefProfile = 'profile';
const prefUserId = 'user_id';
const prefCity = 'city';
const prefState = 'state';
const prefUserRole = 'user_role';
const prefCreatedBy = 'created_by';
const prefAccountStatus = 'account_status';
const prefCreatedAt = 'created_at';
const prefLicenceNumber = 'licence_number';
const prefLicenceExp = 'licence_exp';

/// ************************************ Status Code ************************************************/

const onSuccess = 200;
const onFailed = 417;
const onNotFound = 404;



String getOTPNumber({required int digit}) {
  Random random = Random();
  String number = '';
  for (int i = 0; i < digit; i++) {
    number = number + random.nextInt(9).toString();
  }
  debugPrint(number);
  return number;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*()_+=-/';

String getRandomString({required int length}) {
  Random random = Random();
  var finalString =
  String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length))));
  return finalString;
}
