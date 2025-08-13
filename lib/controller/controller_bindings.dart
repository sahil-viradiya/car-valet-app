import 'package:get/get.dart';
import 'package:wallet_parking/controller/adding_new_controller.dart';
import 'package:wallet_parking/controller/exit_request_controller.dart';
import 'package:wallet_parking/controller/home_controller.dart';
import 'package:wallet_parking/controller/profile_controller.dart';
import 'package:wallet_parking/controller/ticket_controller.dart';

import 'auth_controller.dart';
import 'main_controller.dart';

class AuthControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class MainControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
class TicketControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketController>(() => TicketController());
  }
}

class ProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class AddingNewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddingNewTicketController>(() => AddingNewTicketController());
  }
}

class ExitRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExitRequestController>(() => ExitRequestController());
  }
}

