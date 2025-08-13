import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_parking/resources/tables_keys_values.dart';
import 'package:wallet_parking/router/app_routes.dart';
import 'package:wallet_parking/router/routs_names.dart';
import 'package:wallet_parking/utils/get_storage_manager.dart';
import 'package:wallet_parking/utils/static_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(GetStorageManager.storageName);
  try {
      var app = await Firebase.initializeApp(options: StaticData.platformOptions);
      debugPrint("app name : ${app.name}");
     // await FirebaseApi().defaultAdminCreate();
    // await Firebase.initializeApp(options: StaticData.platformOptions, name: kIsWeb ? '[DEFAULT]' : StaticData.appName);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: "Digital Car Valet",
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, surfaceTint: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: GetStorageManager.getValue(prefIsLogin, false) ? RoutsNames.main : AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
