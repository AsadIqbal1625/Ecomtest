import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../items_details/item_details_screen.dart';
import 'item_model.dart';
import 'item_screen_controller.dart';
import 'package:mypoll2/items_screen/search.dart';

class ItemsScreen extends StatelessWidget {
  final String categoryId, categoryTitle;

  ItemsScreen({Key? key, required this.categoryTitle, required this.categoryId})
      : super(key: key);

  final controller = Get.put(ItemScreenController());
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    controller.categoryTitle = categoryTitle;
    controller.categoryId = categoryId;

    controller.getSubCategoryData();

    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryTitle),
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(children: [
              SizedBox(
                height: size.height / 40,
              ),
              searchBar(size, context),
              Expanded(
                child: SizedBox(
                  child: GetBuilder<ItemScreenController>(builder: (value) {
                    if (!value.isLoading) {
                      return ListView.builder(
                        itemCount: value.itemsData.length,
                        itemBuilder: ((context, index) {
                          return listViewBuilderItems(
                              size, value.itemsData[index]);
                        }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget listViewBuilderItems(Size size, ItemsModel model) {
    int discount =
        controller.calculateDiscount(model.totalPrice, model.sellPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemDetailScreen(id: model.detailsId));
        },
        child: SizedBox(
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
                      TextSpan(
                          text: " $discount % off",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ))
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

  Widget searchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchScreen());
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        child: Container(
          height: size.height / 15,
          width: size.width / 1.1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Search your items here",
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.search,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
