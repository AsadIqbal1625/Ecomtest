import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/address/adress_screen_controller.dart';
import 'package:mypoll2/confirmation/confirmation_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressScreenController>(
        init: AddressScreenController(),
        builder: (value) {
          if (value.isAddressAvailable) {
            return EditAddressScreen();
          } else {
            return AddAddressScreen();
          }
        });
  }
}

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);

  final controller = Get.find<AddressScreenController>();

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Address/Personal info"),
            backgroundColor: Colors.blue,
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                SizedBox(
                  height: size.height / 10,
                  width: size.width / 1.2,
                  child: TextField(
                    controller: controller.nameController,
                    textAlign: TextAlign.justify,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                SizedBox(
                  height: size.height / 15,
                  width: size.width / 1.2,
                  child: TextField(
                    controller: controller.emailController,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                SizedBox(
                  height: size.height / 5,
                  width: size.width / 1.2,
                  child: TextField(
                    controller: controller.addressController,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: size.height / 20,
                // ),
                // SizedBox(
                //   height: size.height / 15,
                //   width: size.width / 1.2,
                //   child: const TextField(
                //     textAlign: TextAlign.justify,
                //     decoration: InputDecoration(
                //       hintText: "Pincode",
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(5),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              controller.onTap();
            },
            child: Container(
              height: size.height / 12,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                "Save to process",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen({Key? key}) : super(key: key);
  final controller = Get.find<AddressScreenController>();
  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Edit/ Edit your address"),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 30,
                  width: size.width / 1.1,
                ),
                addressCard(size),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              Get.to(() => ConfirmationScreen());
            },
            child: Container(
              height: size.height / 12,
              width: size.width / 1.2,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressCard(Size size) {
    return Material(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: size.width / 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                controller.email,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              controller.address,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            GestureDetector(
              onTap: () {
                controller.onEdit();
              },
              child: Container(
                height: size.height / 18,
                width: size.width / 1.2,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Color.fromARGB(122, 121, 44, 2),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
