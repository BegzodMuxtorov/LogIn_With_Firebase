import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";

  Future<void> SignUp() async {
    isLoading = true;
    notifyListeners();
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseException catch (e) {
      if (e.code == "weak-password") {
        errorMessage = 'Parol yaroqsiz';
        print(errorMessage);
        notifyListeners();
      } else if (e.code == "email-already-in-use") {
        errorMessage = 'Siz mavjud emailni kiritdinggiz';
        print(errorMessage);
        notifyListeners();
      } else {
        debugPrint('Unknown');
      }
    }
  }
}
