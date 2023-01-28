

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_app/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login_pafe.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);

  }


  _initialScreen(User? user){
    if (user==null){
      print("login page");
      Get.offAll(()=>LoginPage());
    }else{
      Get.offAll(()=>WelcomePage(email:user.email!));
    }
  }

  void register(String email, password){
    try{
    auth.createUserWithEmailAndPassword(email: email, password: password);

  }catch(e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(
            color: Colors.white

          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white
          )
        )
      );
    }
    }
  void login(String email, password){
    try{
      auth.signInWithEmailAndPassword(email: email, password: password);

    }catch(e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(
                color: Colors.white

            ),
          ),
          messageText: Text(
              e.toString(),
              style: TextStyle(
                  color: Colors.white
              )
          )
      );
    }
  }
  void logOut() async{
    await auth.signOut();
  }

}