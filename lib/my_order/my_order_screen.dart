import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/my_order_details/my_order_details.dart';

import '../const/const.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My order"),
            backgroundColor: Colors.blue,
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return listViewBuilderItems(size);
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget listViewBuilderItems(
  Size size,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: GestureDetector(
      onTap: () {
        Get.to(() => const MyOrderDetailsSxcreen());
      },
      child: SizedBox(
        height: size.height / 8,
        width: size.width / 1.1,
        child: Row(children: [
          Container(
            height: size.height / 5,
            width: size.height / 4.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(
            width: size.width / 15,
          ),
          Expanded(
            child: SizedBox(
              child: RichText(
                text: const TextSpan(
                  text: "Products Name\n",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Well done Iqbal\n",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "Product deatils",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
