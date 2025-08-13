import 'package:get/get.dart';
import 'package:wallet_parking/router/routs_names.dart';
import 'package:wallet_parking/view/Exit_request_screen/exit_request_screen.dart';
import 'package:wallet_parking/view/add_new_ticket_screen/adding_new_screen.dart';

import '../controller/controller_bindings.dart';
import '../view/main_screen/main_screen.dart';
import '../view/sign_in_screen/sign_in_screen.dart';

class AppRoutes {
  // need to change the initial route
  static const initial = RoutsNames.launcher;

  static final routes = [
    GetPage(
      page: () => const SignInScreen(),
      bindings: [AuthControllerBinding()],
      name: RoutsNames.launcher,
    ),
    GetPage(
      page: () => const MainScreen(),
      bindings: [MainControllerBinding()],
      name: RoutsNames.main,
    ),
    GetPage(
      page: () =>const AddingTicketNewScreen(),
      bindings: [AddingNewControllerBinding()],
      name: RoutsNames.addingNew,
    ),
    GetPage(
      page: () => const ExitRequestScreen(),
      bindings: [ExitRequestBinding()],
      name: RoutsNames.exitView,
    ),
  ];
}
