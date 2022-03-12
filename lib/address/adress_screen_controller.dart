import 'package:alert/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mypoll2/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreenController extends GetxController {
  late SharedPreferences _preferences;
  String name = "", email = " ", address = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isAddressAvailable = false;

  Future<void> getInstance() async {
    _preferences = await SharedPreferences.getInstance();

    String address = getString('address');
    if (address.isNotEmpty) {
      isAddressAvailable = true;
    } else {
      isAddressAvailable = false;
    }
    initilizeInfo();
    update();
  }

  void onTap() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      await saveString('name', nameController.text);
      await saveString('email', emailController.text);
      await saveString('address', addressController.text);

      getInstance();
    } else {
      showAlert("hey! All fields are required....");
      // Alert(message: "All fields are required", shortDuration: false);
    }
  }

  void onEdit() async {
    isAddressAvailable = false;

    await _preferences.clear();
    update();
  }

  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String getString(String key) => _preferences.getString(key) ?? "";

  void initilizeInfo() {
    name = getString('name');
    address = getString('address');
    email = getString('email');
  }

  @override
  void onInit() {
    super.onInit();
    getInstance();
  }
}
