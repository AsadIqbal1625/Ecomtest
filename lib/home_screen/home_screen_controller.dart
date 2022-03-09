import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'home_model/banner.dart';
import 'home_model/categories_modal.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<BannerDataModel> bannerData;
  late List<CategoriesModal> categoriesData;
  late List<CategoriesModal> featuredData;
  bool isLooading = true;
  List<RxBool> isSelected = [];
  @override
  void onInit() {
    super.onInit();
    getAllData();
  }

  //initialisizing future function calls
  void getAllData() async {
    await Future.wait([
      getBannerData(),
      getAllCategories(),
      getAllFeatured(),
    ]).then((value) {
      // for printing data values from firestore on console

      isLooading = false;
      update();
    });
  }

  //For changing indicator circle according to banner iamge
  void changeIndicator(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      if (isSelected[i].value) {
        isSelected[i].value = false;
      }
    }

    isSelected[index].value = true;
  }

// banner data function for getting data from firestore
  Future<void> getBannerData() async {
    await _firestore.collection('banner').get().then((value) {
      bannerData =
          value.docs.map((e) => BannerDataModel.fromJson(e.data())).toList();
      for (var i = 0; i < bannerData.length; i++) {
        isSelected.add(false.obs);
      }
      isSelected[0].value = true;
    });
  }

// categories function for getting data from firestore
  Future<void> getAllCategories() async {
    await _firestore.collection('categories').get().then((value) {
      categoriesData =
          value.docs.map((e) => CategoriesModal.fromJson(e.data())).toList();
    });
  }

// featured data function for getting data from firestore
  Future<void> getAllFeatured() async {
    await _firestore.collection('featured').get().then((value) {
      featuredData =
          value.docs.map((e) => CategoriesModal.fromJson(e.data())).toList();
    });
  }
}
