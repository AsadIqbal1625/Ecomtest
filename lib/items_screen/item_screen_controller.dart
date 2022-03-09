import 'package:alert/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'item_model.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String categoryId = "";
  String categoryTitle = "";
  List<ItemsModel> itemsData = [];
  List<ItemsModel> searchResults = [];
  bool isLoading = true;
  bool isSearchLoading = false;

  Future<void> getSubCategoryData() async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
        isLoading = false;

        update();
      });
    } catch (e) {
      Alert(message: "yes $e");
    }
  }

  int calculateDiscount(int totalPrice, int sellPrice) {
    double discount = ((sellPrice - totalPrice) / sellPrice) * 100;
    return discount.toInt();
  }

//   Future<void> searchProducts(String query) async {

//     if(query.isNotEmpty){
//       isSearchLoading = true;
//     }

//     Future.delayed(Duration.zero, () {
//       update();
//     });
//     try {
//       await _firestore
//           .collection('categories')
//           .doc(categoryId)
//           .collection(categoryTitle)
//           .where('title', isGreaterThanOrEqualTo: query)
//           .get()
//           .then(
//         (value) {
//           searchResults =
//               value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
//           isSearchLoading = false;
//           update();
//         },
//       );
//     } catch (e) {
//       print(e);
//     }
//   }
// }
  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      isSearchLoading = true;
      Future.delayed(Duration.zero, () {
        update();
      });

      try {
        await _firestore
            .collection('categories')
            .doc(categoryId)
            .collection(categoryTitle)
            .where('title', isGreaterThanOrEqualTo: query)
            .get()
            .then((value) {
          searchResults =
              value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();

          isSearchLoading = false;

          update();
        });
      } catch (e) {
        Alert(message: "$e");
      }
    }
  }
}
