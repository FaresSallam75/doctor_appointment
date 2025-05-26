import 'dart:io';
import '../web_services(API)/crud.dart';
import 'package:doctor_appointment/link_api.dart';

class AuthRepositary {
  final Crud crud;

  AuthRepositary(this.crud);
  signupData(
    String userName,
    String email,
    String password,
    String phone,
  ) async {
    var response = await crud.getDataFromServer(AppLink.signup, {
      "username": userName,
      "email": email,
      "password": password,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }

  loginData(String email, String password) async {
    var response = await crud.getDataFromServer(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

  getCurrentUserData(String userId) async {
    var response = await crud.getDataFromServer(AppLink.getCurrentUserData, {
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  currentUserTokenData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.currentUserToken, data);
    return response.fold((l) => l, (r) => r);
  }

  checkEmailData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.checkEmail, data);
    return response.fold((l) => l, (r) => r);
  }

  resetPasswordData(Map data) async {
    var response = await crud.getDataFromServer(AppLink.resetPassword, data);
    return response.fold((l) => l, (r) => r);
  }

  updateDataUser(String userId, String oldImage, [File? file]) async {
    // ignore: prefer_typing_uninitialized_variables

    var response = await crud.postRequestWithFile(AppLink.updateUserData, {
      "userId": userId,
      "oldImage": oldImage,
    }, file!);

    return response.fold((l) => l, (r) => r);
  }

  // updateDataUser(
  //   String userId,
  //   String username,
  //   String password,
  //   String phone,
  //   String oldImage, [
  //   File? file,
  // ]) async {
  //   var response;
  //   if (file == null) {
  //     response = await crud.getDataFromServer(AppLink.updateUserData, {
  //       "userId": userId,
  //       "username": username,
  //       "password": password,
  //       "phone": phone,
  //       "oldImage": oldImage,
  //     });
  //   } else {
  //     response = await crud.postRequestWithFile(AppLink.updateUserData, {
  //       "userId": userId,
  //       "username": username,
  //       "password": password,
  //       "phone": phone,
  //       "oldImage": oldImage,
  //     }, file);
  //   }
  //   return response.fold((l) => l, (r) => r);
  // }
}

// void showCustomSnackbar(BuildContext context, String message) {
//   final snackBar = SnackBar(
//     content: Text(message),
//     backgroundColor: Colors.blue,
//     behavior: SnackBarBehavior.floating,
//     margin: const EdgeInsets.all(16),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     duration: const Duration(seconds: 3),
//     action: SnackBarAction(
//       label: 'OK',
//       textColor: Colors.white,
//       onPressed: () {
//         // Do something when 'OK' is pressed.
//       },
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
