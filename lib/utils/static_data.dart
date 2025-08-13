import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/default_response.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class StaticData {
  static RxInt selectedIndex = 1.obs;
  static RxInt selectedPreIndex = 1.obs;

  static String apiBaseUrl = "";
  static String version = "1.0.0";
  static String defaultPlaceHolder = "assets/app_logo/app_logo.png";
  static bool appInDevelopment = !isProduction;
  static String currentDateFormat = "dd/MM/yyyy";

  static List<Color> vehicleColors = [
    Colors.white,
    Colors.grey,
    Colors.black,
    Colors.red,
    Colors.blue,
    const Color(0xffCEB795),
  ];

  static final Map<Color, List<Color>> linearGradientColor = {
    Colors.white : [
     const Color(0xFFFFFFFF),
     const Color(0xFFFFFFFF)
    ],
    Colors.grey : [
      const Color(0xFFF9F9F9),
      const Color(0xFFCACACA),
      const Color(0xFFDEDDE1),
      const Color(0xFFCCCCCC),
    ],
    Colors.black : [
      const Color(0xFF000000),
      const Color(0xFF000000),
    ],
    Colors.red : [
      const Color(0xFFE42F16),
      const Color(0xFFA73A2C),
    ],
    Colors.blue : [
      const Color(0xFF115BBC),
      const Color(0xFF072C67),
    ],
    const Color(0xFFCEB795) : [
      const Color(0xFFCEB795),
      const Color(0xFFCEB795),
    ],
  };

  static List<String> vehicleColorsString = [
    "White",
    "Grey",
    "Black",
    "Red",
    "Blue",
    "Brown",
  ];


  static List<VehicleCompany> vehicleCompanyList = [
    VehicleCompany("Abarth", "hdata:image/png;base64,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"),
    VehicleCompany("Acura", "https://upload.wikimedia.org/wikipedia/commons/7/76/Acura-logo.png"),
    VehicleCompany("Alfa Romeo", "https://upload.wikimedia.org/wikipedia/en/thumb/8/8e/Alfa_Romeo_Logo.svg/1200px-Alfa_Romeo_Logo.svg.png"),
    VehicleCompany("Aston Martin", "https://upload.wikimedia.org/wikipedia/en/thumb/c/c5/Aston_Martin_logo.svg/1200px-Aston_Martin_logo.svg.png"),
    VehicleCompany("Audi", "https://upload.wikimedia.org/wikipedia/commons/6/6f/Audi_logo_detail.png"),
    VehicleCompany("Bentley", "https://upload.wikimedia.org/wikipedia/en/6/6d/Bentley_logo.svg"),
    VehicleCompany("BMW", "https://upload.wikimedia.org/wikipedia/commons/4/44/BMW.svg"),
    VehicleCompany("Bugatti", "https://upload.wikimedia.org/wikipedia/commons/e/ed/Bugatti_logo.svg"),
    VehicleCompany("Buick", "https://upload.wikimedia.org/wikipedia/commons/d/d2/Buick_logo.png"),
    VehicleCompany("Cadillac", "https://upload.wikimedia.org/wikipedia/commons/6/63/Cadillac_logo.png"),
    VehicleCompany("Chevrolet", "https://upload.wikimedia.org/wikipedia/commons/8/85/Chevrolet-logo.png"),
    VehicleCompany("Chrysler", "https://upload.wikimedia.org/wikipedia/en/0/0d/Chrysler_logo.png"),
    VehicleCompany("Citroën", "https://upload.wikimedia.org/wikipedia/commons/0/02/Citroen_logo.png"),
    VehicleCompany("Dacia", "https://upload.wikimedia.org/wikipedia/commons/5/56/Dacia_logo.png"),
    VehicleCompany("Daihatsu", "https://upload.wikimedia.org/wikipedia/en/c/c6/Daihatsu_logo.png"),
    VehicleCompany("Dodge", "https://upload.wikimedia.org/wikipedia/commons/d/d8/Dodge_logo.png"),
    VehicleCompany("Ferrari", "https://upload.wikimedia.org/wikipedia/en/d/d2/Ferrari_logo.svg"),
    VehicleCompany("Fiat", "https://upload.wikimedia.org/wikipedia/commons/8/8f/Fiat_logo.png"),
    VehicleCompany("Ford", "https://upload.wikimedia.org/wikipedia/commons/3/3e/Ford_logo_flat.svg"),
    VehicleCompany("Genesis", "https://upload.wikimedia.org/wikipedia/commons/e/e0/Genesis_Motor_logo.png"),
    VehicleCompany("GMC", "https://upload.wikimedia.org/wikipedia/commons/1/13/GMC_logo.png"),
    VehicleCompany("Honda", "https://upload.wikimedia.org/wikipedia/commons/d/d5/Honda_logo.svg"),
    VehicleCompany("Hyundai", "https://upload.wikimedia.org/wikipedia/commons/4/4e/Hyundai_Motor_Company_logo.svg"),
    VehicleCompany("Infiniti", "https://upload.wikimedia.org/wikipedia/commons/8/8f/Infiniti_logo.png"),
    VehicleCompany("Isuzu", "https://upload.wikimedia.org/wikipedia/commons/1/1d/Isuzu_logo.png"),
    VehicleCompany("Jaguar", "https://upload.wikimedia.org/wikipedia/en/5/5a/Jaguar_logo.png"),
    VehicleCompany("Jeep", "https://upload.wikimedia.org/wikipedia/commons/2/2f/Jeep_logo.svg"),
    VehicleCompany("Kia", "https://upload.wikimedia.org/wikipedia/commons/e/ec/Kia_logo.svg"),
    VehicleCompany("Koenigsegg", "https://upload.wikimedia.org/wikipedia/en/4/4c/Koenigsegg_Crest.png"),
    VehicleCompany("Lamborghini", "https://upload.wikimedia.org/wikipedia/en/d/dd/Lamborghini_logo.svg"),
    VehicleCompany("Lancia", "https://upload.wikimedia.org/wikipedia/en/3/3f/Lancia_logo.png"),
    VehicleCompany("Land Rover", "https://upload.wikimedia.org/wikipedia/en/3/3e/LandRover_logo.svg"),
    VehicleCompany("Lexus", "https://upload.wikimedia.org/wikipedia/commons/e/e8/Lexus_division_emblem.svg"),
    VehicleCompany("Lincoln", "https://upload.wikimedia.org/wikipedia/en/4/4d/Lincoln_logo.png"),
    VehicleCompany("Lotus", "https://upload.wikimedia.org/wikipedia/en/c/cf/Lotus_logo.png"),
    VehicleCompany("Mahindra", "https://upload.wikimedia.org/wikipedia/commons/5/5a/Mahindra_%26_Mahindra_Logo.png"),
    VehicleCompany("Maserati", "https://upload.wikimedia.org/wikipedia/commons/d/db/Maserati_logo.png"),
    VehicleCompany("Mazda", "https://upload.wikimedia.org/wikipedia/commons/f/f4/Mazda_logo_with_emblem.svg"),
    VehicleCompany("McLaren", "https://upload.wikimedia.org/wikipedia/en/5/54/McLaren_Automotive_logo.png"),
    VehicleCompany("Mercedes-Benz", "https://upload.wikimedia.org/wikipedia/commons/9/90/Mercedes-Logo.png"),
    VehicleCompany("Mini", "https://upload.wikimedia.org/wikipedia/commons/2/2e/Mini_logo.png"),
    VehicleCompany("Mitsubishi", "https://upload.wikimedia.org/wikipedia/commons/2/28/Mitsubishi_logo.svg"),
    VehicleCompany("Nissan", "https://upload.wikimedia.org/wikipedia/commons/8/88/Nissan_logo.svg"),
    VehicleCompany("Opel", "https://upload.wikimedia.org/wikipedia/commons/7/7f/Opel_logo.png"),
    VehicleCompany("Peugeot", "https://upload.wikimedia.org/wikipedia/en/0/05/Peugeot_logo.png"),
    VehicleCompany("Porsche", "https://upload.wikimedia.org/wikipedia/en/5/5c/Porsche_logo.svg"),
    VehicleCompany("Ram", "https://upload.wikimedia.org/wikipedia/commons/a/a4/Ram_Trucks_logo.png"),
    VehicleCompany("Renault", "https://upload.wikimedia.org/wikipedia/en/e/e5/Renault_logo.png"),
    VehicleCompany("Rolls-Royce", "https://upload.wikimedia.org/wikipedia/en/1/1c/Rolls-Royce_Motor_Cars_logo.svg"),
    VehicleCompany("Saab", "https://upload.wikimedia.org/wikipedia/en/2/21/Saab_logo.png"),
    VehicleCompany("Subaru", "https://upload.wikimedia.org/wikipedia/commons/0/07/Subaru_logo.png"),
    VehicleCompany("Suzuki", "https://upload.wikimedia.org/wikipedia/commons/8/84/Suzuki_logo_2.svg"),
    VehicleCompany("Tata Motors", "https://upload.wikimedia.org/wikipedia/en/2/24/Tata_Motors_logo.png"),
    VehicleCompany("Tesla", "https://upload.wikimedia.org/wikipedia/commons/b/bb/Tesla_T_symbol.svg"),
    VehicleCompany("Toyota", "https://upload.wikimedia.org/wikipedia/commons/9/9d/Toyota_logo.svg"),
    VehicleCompany("Volkswagen", "https://upload.wikimedia.org/wikipedia/commons/8/8a/Volkswagen_logo_2019.png"),
    VehicleCompany("Volvo", "https://upload.wikimedia.org/wikipedia/commons/1/1f/Volvo_Ironmark_black.svg"),
    VehicleCompany("Zenvo", "https://upload.wikimedia.org/wikipedia/en/1/1c/Zenvo_logo.png"),
    VehicleCompany("Other", "https://upload.wikimedia.org/wikipedia/en/1/1c/Zenvo_logo.png"),
  ];

  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyCwQsKd_K6guZVhBWSCnjNm0Umaud4dk-8",
          authDomain: "carvalet-643b3.firebaseapp.com",
          projectId: "carvalet-643b3",
          storageBucket: "carvalet-643b3.firebasestorage.app",
          messagingSenderId: "988964103627",
          appId: "1:988964103627:web:a482062febb8e3754e424e",
          measurementId: "G-3H0R0239LS"
      );
      // return const FirebaseOptions(
      //     apiKey: "AIzaSyCwQsKd_K6guZVhBWSCnjNm0Umaud4dk-8",
      //     authDomain: "carvalet-643b3.firebaseapp.com",
      //     projectId: "carvalet-643b3",
      //     storageBucket: "carvalet-643b3.firebasestorage.app",
      //     messagingSenderId: "988964103627",
      //     appId: "1:988964103627:web:a482062febb8e3754e424e",
      //     measurementId: "G-3H0R0239LS"
      // );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: "AIzaSyAnb8rdTXcC7bPX3ZwRKM5grSelZ2UK2eY",
        authDomain: "carvalet-643b3.firebaseapp.com",
        projectId: "carvalet-643b3",
        storageBucket: "carvalet-643b3.firebasestorage.app",
        messagingSenderId: "988964103627",
        appId: "1:988964103627:ios:4f1aad2c8df646d84e424e",
        measurementId: "G-3H0R0239LS",
        iosBundleId: 'com.garage',

        // iosClientId:
        //     '942082737300-3e41dal91j9ccogun8te3m5611s3qtou.apps.googleusercontent.com',
      );//check
      // return const FirebaseOptions(
      //     apiKey: "AIzaSyD0-0XcOG_gcuIFdmnNbUP3QnUM9clrkb0",
      //     authDomain: "test.firebaseapp.com",
      //     projectId: "test",
      //     storageBucket: "test.appspot.com",
      //     messagingSenderId: "942082737300",
      //     appId: "1:942082737300:android:96f3b3597e03b9023fa081",
      //     measurementId: "G-SM0YJNF337",
      //     iosBundleId: 'com.garage',
      //     iosClientId:
      //         '942082737300-3e41dal91j9ccogun8te3m5611s3qtou.apps.googleusercontent.com');
    } else {
      // Android
      return const FirebaseOptions(
        apiKey: "AIzaSyBzH8-4I4ozS3G8DyczG-Dhv4d-UgvwAmk",
        authDomain: "car-valet-f5c1f.firebaseapp.com",
        projectId: "car-valet-f5c1f",
        storageBucket: "car-valet-f5c1f.firebasestorage.app",
        messagingSenderId: "365059244024",
        appId: "1:365059244024:android:b0e046601f243091dc200d",
        // measurementId: "G-07NW1S0B0W",
      );//check
  }
    //   return const FirebaseOptions(
    //       apiKey: "AIzaSyDQE29pDETdyxAC9XaTRhTFfaaet9ikbw4",
    //       authDomain: "car-valet-ae909.firebaseapp.com",
    //       projectId: "car-valet-ae909",
    //       storageBucket: "car-valet-ae909.appspot.com",
    //       messagingSenderId: "947884516786",
    //       appId: "1:947884516786:android:f13c5380bba3894515b0ab",
    //       measurementId: "G-07NW1S0B0W");
    // }
  }
}

enum DeviceType { android, web, ios }
