import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/authentication/login_screen/custom_button.dart';

import 'package:mypoll2/authentication/login_screen/login_screen_view.dart';
import 'package:mypoll2/authentication/login_screen/loginscreen_controller.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;
  final TextEditingController otpController = TextEditingController();

  OtpVerificationScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    LoginScreenController controller = Get.find();
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: SafeArea(
          child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height / 7,
                  width: size.width / 3,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 52, 216, 208),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                      )),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: size.width / 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Verification\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width / 10,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Enter your One Time Password\nEnjoy the world",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: size.width / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: size.height / 15,
              ),
              SizedBox(
                height: size.height / 18,
                width: size.width / 1.2,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpController,
                  onChanged: (val) async {},
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      inactiveColor: Colors.red,
                      activeColor: Colors.black,
                      fieldHeight: size.height / 18,
                      fieldWidth: size.width / 8),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              CustomButton(
                  text: "Submit",
                  buttonWidth: 2.5,
                  function: () {
                    controller.signInWithPhone(
                        verificationId, otpController.text);
                  }),
            ],
          )),
        ),
      )),
    );
  }
}
