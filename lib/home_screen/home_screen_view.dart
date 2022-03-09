//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypoll2/authentication/auth_services.dart';

import '../cart_screen/cart_screen.dart';
import '../categories_featured/categories_features.dart';
import '../items_screen/item_screen_view.dart';
import 'drawer.dart';
import 'home_model/categories_modal.dart';
import 'home_screen_controller.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(HomeScreenController());
    return Container(
      color: Colors.blue[400],
      child: SafeArea(
        child: GetBuilder<HomeScreenController>(
          builder: (value) {
            if (!value.isLooading) {
              return Scaffold(
                //app bar upper banner
                appBar: AppBar(
                  title: const Text("Lucky Dream"),
                  backgroundColor: Colors.blue[400],
                  actions: [
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const SizedBox(height: 1.0),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => CartScreen());
                        },
                        icon: const Icon(Icons.shopping_cart)),
                    ElevatedButton(
                      onPressed: () {
                        AuthService().signOut();
                      },
                      child: const Center(
                        child: Text('Sign out'),
                      ),
                    ),
                  ],
                ),
                //Homescreen drawer class is calling from home
                drawer: const HomeScreenDrawer(),
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // front Banner UI code
                        SizedBox(
                          height: size.height / 3,
                          width: size.width / 1.5,
                          child: PageView.builder(
                            itemCount: controller.bannerData.length,
                            onPageChanged: controller.changeIndicator,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          controller.bannerData[index].image),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        //indicator : rolling indicator on front screen below banner
                        SizedBox(
                          height: size.height / 25,
                          width: size.width,
                          child: Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < controller.isSelected.length;
                                    i++)
                                  indicacator(
                                      size, controller.isSelected[i].value)
                              ],
                            );
                          }),
                        ),
                        //Categories and featured initialization
                        categoriesTitle(size, "All categories", () {
                          Get.to(() => CategoriedAndFeaturedScreen(
                                model: controller.categoriesData,
                              ));
                        }),
                        listViewBuilder(size, controller.categoriesData),
                        SizedBox(
                          height: size.height / 25,
                        ),
                        categoriesTitle(size, "Winners", () {
                          Get.to(() => CategoriedAndFeaturedScreen(
                                model: controller.featuredData,
                              ));
                        }),
                        listViewBuilderwinner(size, controller.featuredData),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            }
          },
        ),
      ),
    );
  }

  Widget listViewBuilder(Size size, List<CategoriesModal> data) {
    return SizedBox(
      height: size.height / 9,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, data[index]);
        },
      ),
    );
  }

  Widget listViewBuilderwinner(Size size, List<CategoriesModal> data) {
    return SizedBox(
      height: size.height / 3,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, data[index]);
        },
      ),
    );
  }

  Widget listViewBuilderItems(Size size, CategoriesModal categories) {
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
                height: size.height / 10,
                width: size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categories.image),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Text(
                    categories.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
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

  Widget categoriesTitle(Size size, String title, Function function) {
    return SizedBox(
      height: size.height / 18,
      width: size.width / 1.1,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        TextButton(
          onPressed: () => function(),
          child: const Text(
            " View All",
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
            ),
          ),
        ),
      ]),
    );
  }

  Widget indicacator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.height / 80 : size.height / 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      ),
    );
  }
}
