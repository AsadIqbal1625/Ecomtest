import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:mypoll2/address/adress_screen_controller.dart';
import 'package:mypoll2/cart_screen/cart_screen_controller.dart';
import 'package:mypoll2/const/const.dart';
import 'package:mypoll2/home_screen/home_screen_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:razorpay_web/razorpay_web.dart';

class ConfirmationScreenController extends GetxController {
  final addressScreenController = Get.find<AddressScreenController>();
  final cartScreenController = Get.find<CartScreenController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final Razorpay _razorpay = Razorpay();

  String name = "", email = "", address = "";
  int totalPrice = 0, totalDiscount = 0, totalPayablePrice = 0;

  void initializData() {
    name = addressScreenController.name;
    email = addressScreenController.email;
    address = addressScreenController.address;

    totalPrice = cartScreenController.totalPrice;
    totalDiscount = cartScreenController.totaldiscount;
    totalPayablePrice = cartScreenController.totalSellPrice;
  }

  void onPay() {
    try {
      if (kIsWeb) {
        RazorpayWeb(
          rzpKey: 'rzp_test_9DvuyrgTytoPQx', // Enter Your Razorpay Key Here
          options: RzpOptions(
            amount: 1000,
            name: "Razorpay",
            description: "Test Payment",
            image: "https://i.imgur.com/3g7nmJC.png",
            prefill: const PrefillData(
              name: "Razorpay",
              email: "rzp@gmail.com",
              contact: "9876543210",
            ),
            colorhex: "#FF0000",
          ),
          onPaymentSuccess: (String paymentId) {
            Future.wait([
              placeOrder(paymentId),
              addToMyOrder(paymentId),
            ]).then((value) {
              showAlert("Payment Successful");
              Get.to(() => const HomeScreenView());
            });
            showAlert("Payment Success");
           // print(paymentId);
          },
          onPaymentError: (String error) {
            showAlert("Payment Error");
          },
        );
      } else {
        var options = {
          'key': 'rzp_test_9DvuyrgTytoPQx',
          'amount': cartScreenController.totalPrice * 100,
          'name': 'Acme Corp.',
          'description': 'Fine T-Shirt',
          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
        };
        _razorpay.open(options);
      }
    } catch (e) {
      showAlert("Something went Wrong");
    }
  }

  @override
  void onInit() {
    super.onInit();
    initializData();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> placeOrder(String orderId) async {
    try {
      Map<String, dynamic> details = {
        'orderId': orderId,
        'productsId': cartScreenController.productId,
        'name': name,
        'email': email,
        'address': address,
        'mobile': _auth.currentUser!.phoneNumber,
        'status': 0,
        'time': FieldValue.serverTimestamp(),
      };

      await _firebaseFirestore.collection('orders').add(details);
    } catch (e) {
      showAlert("Bugs and Error");
    }
  }

  Future<void> addToMyOrder(String orderId) async {
    try {
      for (var i = 0; i < cartScreenController.productsDetails.length; i++) {
        Map<String, dynamic> orderDetails = {
          'img': cartScreenController.productsDetails[i].image,
          'name': cartScreenController.productsDetails[i].title,
          'orderId': orderId,
          'total_price': cartScreenController.productsDetails[i].totalPrice,
          'sell_price': cartScreenController.productsDetails[i].sellPrice,
          'status': 0,
          'order_on': FieldValue.serverTimestamp(),
          'deliver_on': FieldValue.serverTimestamp(),
        };
        await _firebaseFirestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('myorders')
            .add(orderDetails);
      }
    } catch (e) {
      showAlert("Error");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Future.wait([
      placeOrder(response.orderId ?? ""),
      addToMyOrder(response.orderId ?? ""),
    ]).then((value) {
      showAlert("Payment Successful");
      Get.to(() => const HomeScreenView());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showAlert("Payment failed due to network");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showAlert("Payment Failed");
  }
}
