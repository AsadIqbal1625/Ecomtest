import 'package:alert/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mypoll2/items_details/item_detail_model.dart';

class ItemDetailController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;
  bool isAlreadyAvailable = false;
  late ItemDetailsModel model;
  int discount = 0;

  Future<void> getItemDetails(String id) async {
    try {
      await _firestore.collection('products').doc(id).get().then((value) {
        model = ItemDetailsModel.fromJson(value.data()!);
        discount = calculateDiscount(model.totalPrice, model.sellPrice);
        checkIfAlreadyInCart();
      });
    } catch (e) {
      Alert(message: "Yahoo!!! $e");
    }
  }

  Future<void> checkIfAlreadyInCart() async {
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .where('id', isEqualTo: model.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isAlreadyAvailable = true;
        }
        isLoading = false;
        update();
      });
    } catch (e) {
      Alert(message: "$e");
    }
  }

  Future<void> addItemsToCart() async {
    isLoading = true;
    update();
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(model.id)
          .set({'id': model.id}).then((value) {
        checkIfAlreadyInCart();
      });
    } catch (e) {
      Alert(message: "$e");
    }
  }

  int calculateDiscount(int totalPrice, int sellPrice) {
    double discount = ((sellPrice - totalPrice) / sellPrice) * 100;
    return discount.toInt();
  }
}
