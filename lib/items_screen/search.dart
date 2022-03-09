import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mypoll2/home_screen/home_screen_view.dart';

import 'item_model.dart';
import 'item_screen_controller.dart';
import 'item_screen_view.dart';

class SearchScreen extends SearchDelegate {
  ItemScreenController controller = Get.find();
  String categoryTitle = "", categoryId = "";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            Get.to(const HomeScreenView());
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.to(ItemsScreen(
              categoryTitle: categoryTitle, categoryId: categoryId));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchProducts(query);
    return GetBuilder<ItemScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.itemsData.length,
          itemBuilder: ((context, index) {
            return listViewBuilderItems(Get.size, value.itemsData[index]);
          }),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchProducts(query);
    return GetBuilder<ItemScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.itemsData.length,
          itemBuilder: ((context, index) {
            return listViewBuilderItems(Get.size, value.itemsData[index]);
          }),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget listViewBuilderItems(Size size, ItemsModel model) {
    // int discount =
    //     controller.calculateDiscount(model.totalPrice, model.sellPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: size.height / 8,
        width: size.width / 1.1,
        child: Row(children: [
          Container(
            height: size.height / 5,
            width: size.height / 4.5,
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
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "${model.totalPrice}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "${model.sellPrice}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
