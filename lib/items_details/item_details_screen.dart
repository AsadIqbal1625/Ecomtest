import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/items_details/item_details_controller.dart';

import '../cart_screen/cart_screen.dart';

// ignore: must_be_immutable
class ItemDetailScreen extends StatelessWidget {
  String id;
  ItemDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(ItemDetailController());

    controller.getItemDetails(id);

    return Container(
      color: Colors.lightBlueAccent,
      child: SafeArea(
        child: GetBuilder<ItemDetailController>(
          builder: (value) {
            if (!controller.isLoading) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => CartScreen());
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                  title: const Text("items details"),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // front Banner UI code
                        SizedBox(
                          height: size.height / 3,
                          width: size.width,
                          child: PageView.builder(
                            itemCount: 1,
                            // onPageChanged: controller.changeIndicator,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller.model.image,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height / 25,
                          width: size.width / 1,
                        ),
                        SizedBox(
                          child: Text(
                            controller.model.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 25,
                        ),
                        SizedBox(
                          width: size.width / 1.1,
                          child: RichText(
                            text: TextSpan(
                              text: "${controller.model.totalPrice}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TextSpan(
                                  text: "${controller.model.sellPrice}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: "${controller.discount} % off",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 25,
                        ),
                        SizedBox(
                          width: size.width / 1.1,
                          child: const Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 7, 65, 37),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 45,
                        ),
                        SizedBox(
                          width: size.width / 1.1,
                          child: Text(
                            controller.model.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 24,
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text("See Reviews"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          leading: const Icon(Icons.star),
                        ),
                        SizedBox(
                          height: size.height / 24,
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SizedBox(
                  height: size.height / 14,
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: customButton(
                          size,
                          () {
                            if (controller.isAlreadyAvailable) {
                              Get.to(() => CartScreen());
                            } else {
                              controller.addItemsToCart();
                            }
                          },
                          Colors.white,
                          controller.isAlreadyAvailable
                              ? "Go to Cart"
                              : "Add to Cart",
                        ),
                      ),
                      Expanded(
                        child:
                            customButton(size, () {}, Colors.blue, "Buy Now"),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget customButton(Size size, Function function, Color color, String title) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: color == const Color.fromARGB(255, 58, 150, 211)
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
