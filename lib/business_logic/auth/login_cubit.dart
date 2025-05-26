import 'package:doctor_appointment/business_logic/auth/Login_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/showalertdialog.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/repositary/auth_repositary.dart';
import 'package:doctor_appointment/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepositary authRepositary;

  String? token;

  LoginCubit(this.authRepositary) : super(const LoginStateLoading()) {
    Future.sync(() async {
      await Future.delayed(const Duration(seconds: 3));
      emit(const LoginStateLoaded(successMessage: ''));
    });
  }

  getUserToken() async {
    try {
      await FirebaseMessaging.instance.getToken().then((value) {
        print("========================== Value Of Token $value");
        // ignore: unused_local_variable
        token = value;
      });
    } catch (e) {
      throw Exception("Error getting token: ============================ $e");
    }
  }

  login(BuildContext context, String email, String password) async {
    // emit(const LoginStateLoading());
    var response = await authRepositary.loginData(email, password);
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        print("success =================================== ");
        myBox!.put("userId", response['data']['user_id'].toString());
        myBox!.put("userName", response['data']['user_name']);
        myBox!.put("userEmail", response['data']['user_email']);
        myBox!.put(
          "userPassword",
          response['data']['user_password'].toString(),
        );
        myBox!.put("userPhone", response['data']['user_phone']).toString();
        myBox!.put("userImage", response['data']['user_image'].toString());

        print("================================== ");
        print("${myBox!.get("userId")}");
        print("${myBox!.get("userName")}");
        print("${myBox!.get("userEmail")}");
        print("${myBox!.get("userPassword")}");
        print("${myBox!.get("userPhone")}");
        print("${myBox!.get("userImage")}");
        print("================================== ");
        emit(const LoginStateLoaded(successMessage: "Login successful!"));
        FirebaseMessaging.instance.subscribeToTopic('fares');
        await addCurrentUserToken();
        Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
      } else {
        functionShowAlertDialog(
          context,
          "Alert",
          "Email Or Password Not Correct ....",
          "OK",
          "Cancel",
          () {
            Navigator.of(context).pop();
          },
          () {
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  addCurrentUserToken() async {
    var response = await authRepositary.currentUserTokenData({
      "userId": myBox!.get("userId"),
      "token": token,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        token = "";
        emit(const LoginStateLoading());

        print("=========================================");
        print("Token Add Successfully ...");
      } else {
        print("Something Went Wrong ...");
      }
    }
  }

  checkEmail(BuildContext context, String email) async {
    var response = await authRepositary.checkEmailData({"email": email});
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        emit(const LoginStateLoaded(successMessage: "Success"));

        Navigator.pushReplacementNamed(
          context,
          AppRotes.forgetPassword,
          arguments: {"email": email},
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email Not Found  ❌")));
      }
    }
  }

  resetPassword(BuildContext context, String email, String password) async {
    var response = await authRepositary.resetPasswordData({
      "email": email,
      "password": password,
    });
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        print("Password Changed Successfully .");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Password does't Match ❌")));
      }
    }
  }
}
