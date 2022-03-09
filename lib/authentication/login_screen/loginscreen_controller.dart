// ignore: avoid_web_libraries_in_flutter

import 'package:alert/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:mypoll2/authentication/login_screen/otp_screen_view.dart';

import '../../home_screen/home_screen_view.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController phone = TextEditingController();
  final TextEditingController otp = TextEditingController();
  String mVerificationId = "";
  String wVerificationId = "";
  bool isLoading = false;

  void verifyphonenumber() async {
    isLoading = true;
    update();
    try {
      if (kIsWeb) {
        // ConfirmationResult confirmationResult =
        //     await _auth.signInWithPhoneNumber("+971${phone.text}");
        // Alert(message: "code sent");

        // Get.to(() => OtpVerificationScreen(
        //     verificationId: confirmationResult.toString()));

        // UserCredential userCredential =
        //     await confirmationResult.confirm('123456');
        // await _auth.signInWithPhoneNumber(
        //     "+971${phone.text}",

        //     RecaptchaVerifier(
        //       container: 'recaptcha',
        //       size: RecaptchaVerifierSize.compact,
        //       theme: RecaptchaVerifierTheme.dark,
        //     ));
      } else {
        await _auth.verifyPhoneNumber(
            phoneNumber: "+971${phone.text}",
            timeout: const Duration(seconds: 120),
            verificationCompleted: (PhoneAuthCredential credential) async {
              await _auth.signInWithCredential(credential);
              Alert(message: "Verification Succesful", shortDuration: true)
                  .show();
            },
            verificationFailed: (FirebaseAuthException exception) {
              Alert(
                      message:
                          "Verification failed due to some reason $exception",
                      shortDuration: false)
                  .show();
            },
            codeSent: (String _verificationId, int? forceRespondToken) {
              Alert(message: 'Verification code sent', shortDuration: false)
                  .show();
              mVerificationId = _verificationId;
              Get.to(
                  () => OtpVerificationScreen(verificationId: mVerificationId));
            },
            codeAutoRetrievalTimeout: (String _verificationId) {
              mVerificationId = _verificationId;
            });
      }
    } catch (e) {
      Alert(message: "$e", shortDuration: true).show();
    }
  }

  void signInWithPhone(String mVID, String mOtp) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: mVID,
        smsCode: mOtp,
      );
      var signInUser = await _auth.signInWithCredential(credential);
      final User? user = signInUser.user;

      Alert(message: "successful,user UID: ${user!.uid}", shortDuration: false)
          .show();
      Get.to(() => const HomeScreenView());
    } catch (e) {
      Alert(message: 'Catch exception $e', shortDuration: false).show();
    }
  }
}
