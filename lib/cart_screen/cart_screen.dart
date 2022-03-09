import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/address/address_screen.dart';

import 'package:mypoll2/cart_screen/cart_screen_controller.dart';
import 'package:mypoll2/items_details/item_detail_model.dart';
import 'package:mypoll2/items_details/item_details_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final controller = Get.put(CartScreenController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(child: GetBuilder<CartScreenController>(builder: (value) {
        if (!controller.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Cart"),
              backgroundColor: Colors.blue,
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                itemCount: controller.productsDetails.length,
                itemBuilder: (context, index) {
                  return cartItems(size, controller.productsDetails[index]);
                },
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: size.height / 12,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "     ${value.totalPrice} AED",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AddressScreen());
                      },
                      child: Container(
                        height: size.height / 10,
                        width: size.width / 2,
                        alignment: Alignment.center,
                        color: Colors.blueGrey,
                        child: const Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      })),
    );
  }

  Widget cartItems(Size size, ItemDetailsModel model) {
    int dis = controller.calculateDiscount(model.totalPrice, model.sellPrice);
    return GestureDetector(
      onTap: () {
        Get.to(ItemDetailScreen(id: model.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 9),
        child: Container(
          height: size.height / 3,
          width: size.width / 1.05,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: size.height / 8,
                  width: size.width / 1.1,
                  child: Row(children: [
                    Container(
                      height: size.height / 5,
                      width: size.height / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(model.image),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 15,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: RichText(
                          text: TextSpan(
                            text: "${model.title}\n",
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "${model.totalPrice}AED",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "${model.sellPrice}\n",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              // ignore: prefer_const_constructors
                              TextSpan(
                                  text: "$dis % off",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              const Text(
                " will be delivered",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.removeFromCart(model.id);
                },
                title: const Text(
                  "Remove from cart",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
