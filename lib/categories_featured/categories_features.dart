import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/items_screen/item_screen_view.dart';

import '../home_screen/home_model/categories_modal.dart';

// ignore: must_be_immutable
class CategoriedAndFeaturedScreen extends StatelessWidget {
  List<CategoriesModal> model;
  CategoriedAndFeaturedScreen({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text(" All categories"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: model.length,
              itemBuilder: (context, index) {
                return gridViewBuilderItems(Get.size, model[index]);
              }),
        ),
      )),
    );
  }

  Widget gridViewBuilderItems(Size size, CategoriesModal categories) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ItemsScreen(
                categoryId: categories.id,
                categoryTitle: categories.title,
              ));
        },
        child: SizedBox(
          height: size.height / 5,
          width: size.height / 4,
          child: Column(
            children: [
              Container(
                height: size.height / 5,
                width: size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categories.image),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 1000,
              ),
              Expanded(
                child: SizedBox(
                  child: Text(
                    categories.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
