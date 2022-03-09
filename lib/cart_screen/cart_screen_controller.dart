import 'package:alert/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mypoll2/items_details/item_detail_model.dart';

class CartScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List productId = [];
  List<ItemDetailsModel> productsDetails = [];
  bool isLoading = true;
  int totalPrice = 0, totaldiscount = 0;
  int totalSellPrice = 0;

  Future<void> getCartItems() async {
    productsDetails = [];
    productId = [];
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .get()
          .then((value) {
        productId = value.docs.map((e) => e.data()['id']).toList();
        getProductDetail();
      });
    } catch (e) {
      Alert(message: "$e");
    }
  }

  Future<void> getProductDetail() async {
    totalPrice = 0;
    totaldiscount = 0;
    totalSellPrice = 0;

    for (var item in productId) {
      try {
        await _firestore.collection('products').doc(item).get().then((value) {
          productsDetails.add(ItemDetailsModel.fromJson(value.data()!));
        });
      } catch (e) {
        Alert(message: "$e");
      }
    }
    calculatePrice();
    isLoading = false;
    update();
  }

  Future<void> removeFromCart(String id) async {
    isLoading = true;
    update();
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(id)
          .delete()
          .then((value) {
        getCartItems();
      });
    } catch (e) {
      Alert(message: "$e");
    }
  }

  int calculateDiscount(int totalPrice, int sellPrice) {
    double discount = ((sellPrice - totalPrice) / sellPrice) * 100;
    return discount.toInt();
  }

  void calculatePrice() {
    for (var item in productsDetails) {
      totalPrice = totalPrice + item.totalPrice;
      totalSellPrice = totalSellPrice + item.sellPrice;
    }

    totaldiscount = totalPrice - totalSellPrice;
  }

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }
}
