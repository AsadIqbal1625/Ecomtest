import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/authentication/login_screen/custom_button.dart';
import 'package:mypoll2/authentication/login_screen/loginscreen_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final controller = Get.put(LoginScreenController());
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<LoginScreenController>(
              init: LoginScreenController(),
              builder: (value) {
                if (!value.isLoading) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Material(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(100)),
                            color: const Color.fromARGB(255, 52, 216, 208),
                            child: SizedBox(
                              height: size.height / 2,
                              width: size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height / 10,
                                  ),
                                  Text(
                                    "Dream Lucky",
                                    style: TextStyle(
                                        letterSpacing: 1.2,
                                        color: const Color.fromARGB(
                                            255, 0, 39, 71),
                                        fontSize: size.width / 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Its not normal shopping app,\nTry your luck here and won",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: size.width / 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 12,
                                  ),
                                  SizedBox(
                                    height: size.height / 70,
                                  ),
                                  SizedBox(
                                    width: size.width / 1.4,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: size.height / 10,
                                          width: size.width / 150,
                                          color: const Color.fromARGB(
                                              255, 0, 39, 71),
                                        ),
                                        SizedBox(
                                          width: size.width / 40,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "Welcome\n",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width / 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Enter your Phone number \nfor making yourself lucky",
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: size.width / 22,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 15,
                          ),
                          Container(
                            height: size.height / 15,
                            width: size.width / 1.2,
                            padding: const EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 52, 216, 208),
                              ),
                            ),
                            child: TextField(
                              controller: controller.phone,
                              maxLength: 9,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number",
                                counterText: "",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 10,
                          ),
                          SizedBox(
                            child: Center(
                                child: CustomButton(
                              text: "Login",
                              buttonWidth: 2.2,
                              function: () {
                                controller.verifyphonenumber();
                              },
                              radius: BorderRadius.circular(10),
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
