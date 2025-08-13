
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_parking/controller/auth_controller.dart';
import 'package:wallet_parking/resources/color_code.dart';
import 'package:wallet_parking/resources/custum_textfield.dart';

import '../../utils/validation_utils.dart';

class SignInScreen extends GetView<AuthController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorCode.kYellow,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [ColorCode.kYellow, Color.fromARGB(255, 194, 160, 38)],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi! Welcome back",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: ColorCode.klightBlcktext,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        " SIGN IN ",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: ColorCode.kwhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "to",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: ColorCode.klightBlcktext,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue using ",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: ColorCode.klightBlcktext,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Valet parking!",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: ColorCode.klightBlcktext,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset(
                    "assets/images/sign_in_car.svg",
                  ),
                ],
              ),
            ),
            Container(
              // height: 1000,
              color: const Color.fromARGB(255, 194, 160, 38),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Form(
                  key: controller.formStateKey,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Email", style: TextStyle(fontSize: 16, color: ColorCode.klightBlcktext, fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    controller: controller.emailController,
                                    validator: (value) => validateEmail(value),
                                    hintText: 'Enter email',
                                  ),
                                  if (controller.emailError.value.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        controller.emailError.value,
                                        style: const TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Password",
                            style: TextStyle(fontSize: 16, color: ColorCode.klightBlcktext, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: controller.passwordController,
                                    obscureText: controller.isShow.value,
                                    validator: (value)=>
                                        validatePassword(value),
                                    decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            controller.isShow.value = !controller.isShow.value;
                                          },
                                          child: Icon(
                                            controller.isShow.value ? Icons.visibility : Icons.visibility_off,
                                            color: ColorCode.klightBlcktext,
                                          ),
                                        ),
                                        hintText: "Enter password",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          color: Colors.grey.shade500,
                                        ),
                                        fillColor: ColorCode.ktextfieldClr,
                                        filled: true,
                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10))),
                                  ),
                                  if (controller.passwordError.value.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        controller.passwordError.value,
                                        style: const TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              )),
                          const SizedBox(
                            height: 55,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(controller.formStateKey.currentState!.validate()){
                              controller.signIn();}
                            },
                            child: Container(
                              height: 55,
                              decoration: const BoxDecoration(color: ColorCode.kYellow, borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: const Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      color: ColorCode.kbuttonTextClr,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: GestureDetector(
      //   onTap: () {
      //     controller.signIn();
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.only(bottom: 45, right: 18, left: 18, top: 25),
      //     child: Container(
      //       height: 55,
      //       decoration: const BoxDecoration(color: ColorCode.kYellow, borderRadius: BorderRadius.all(Radius.circular(8))),
      //       child: const Center(
      //           child: Text(
      //         "SIGN IN",
      //         style: TextStyle(
      //           fontFamily: "Inter",
      //           fontSize: 16,
      //           color: ColorCode.kbuttonTextClr,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       )),
      //     ),
      //   ),
      // ),
    );
  }
}
