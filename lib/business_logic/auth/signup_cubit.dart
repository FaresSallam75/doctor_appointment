import 'dart:io';

import 'package:doctor_appointment/business_logic/auth/signup_state.dart';
import 'package:doctor_appointment/constants/handlingdata.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/statusrequest.dart';
import 'package:doctor_appointment/data/repositary/auth_repositary.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepositary authRepositary;

  String? getUserImage;

  SignUpCubit(this.authRepositary) : super(const SignUpStateLoading()) {
    Future.sync(() async {
      await Future.delayed(const Duration(seconds: 3));
      emit(const SignUpStateLoaded(successMessage: ''));
    });
  }

  Future<void> signup(
    BuildContext context,
    String userName,
    String email,
    String password,
    String phone,
  ) async {
    try {
      emit(const SignUpStateLoading()); // ✅ Ensure loading state is emitted
      print("📡 Sending request...");

      var response = await authRepositary.signupData(
        userName,
        email,
        password,
        phone,
      ); // ✅ Await the response
      print("📡 Response received: $response");

      StatusRequest statusRequest = handlingData(response);
      print("✅ Status after handling: $statusRequest");

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        emit(const SignUpStateLoaded(successMessage: "Signup successful!"));
        Navigator.pushReplacementNamed(context, AppRotes.login);
        print("🎉 Success state emitted");
      } else {
        emit(const SignUpStateError(errorMessage: "Signup failed. Try again."));
        print("❌ Error state emitted: ${response['message']}");
      }
    } catch (e) {
      emit(
        SignUpStateError(errorMessage: "An error occurred: ${e.toString()}"),
      );
      print("❌ Exception caught: $e");
    }
  }

  updateUserData(File imageFile) async {
    var response = await authRepositary.updateDataUser(
      myBox!.get("userId").toString(),
      getUserImage ?? "",
      imageFile,
    );

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        if (myBox!.containsKey("userImage")) {
          await myBox!.delete("userImage");
        }
        await myBox!.put("userImage", getUserImage);

        emit(
          const SignUpStateLoaded(
            successMessage: "Photo updated successfully!",
          ),
        );

        print("🎉 Photo update success state emitted");
      }
    } else {
      emit(const SignUpStateError(errorMessage: "Photo update failed."));
      print("❌ Photo update error state emitte");
    }
  }

  getCurrentUser() async {
    var response = await authRepositary.getCurrentUserData(
      myBox!.get("userId").toString(),
    );
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        getUserImage = response['data']["user_image"];
        print("response =================${response['data']}");
        print("userId ======== ${response['data']["user_id"].toString()}");
        print("user_image ======== ${response['data']["user_image"]}");
        print("user_name ======== ${response['data']["user_name"]}");
      } else {
        print("status failure ================ ");
      }
    }

    //emit(const LoginStateError(errorMessage: "Backend error!"));

    /*  if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        emit(const LoginStateLoaded(successMessage: "Login successful!"));
      } else {
        emit(const LoginStateError(errorMessage: "Login failed. Try again."));
      } */
  }
}
