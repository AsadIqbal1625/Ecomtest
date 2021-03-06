import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/confirmation/confirmation_screen_controller.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({Key? key}) : super(key: key);

  final controller = Get.put(ConfirmationScreenController());
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Confirmation"),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 30,
                ),
                addressCard(size),
                SizedBox(
                  height: size.height / 40,
                ),
                orderDetails(size),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              controller.onPay();
            },
            child: Container(
              height: size.height / 12,
              width: size.width / 1.2,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                "Pay Now",
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
          ],
        ),
      ),
    );
  }

  Widget orderDetails(Size size) {
    Widget text(String header, String footer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            footer,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: size.width / 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: text('Total Price :', '${controller.totalPrice} AED'),
            ),
            text('Discount :', '${controller.totalDiscount}AED'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: text('Coupan  :', 'wqw2o3nej8872h'),
            ),
            text('Draw date :', '30Feb'),
            SizedBox(
              height: size.height / 30,
            )
          ],
        ),
      ),
    );
  }
}
