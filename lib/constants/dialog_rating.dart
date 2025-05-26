import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

void showDialogRating(
  BuildContext context,
  dynamic Function(RatingDialogResponse) onSubmitted,
) {
  showDialog(
    context: context,
    barrierDismissible: true, // set to false if you want to force a rating
    builder:
        (context) => RatingDialog(
          initialRating: 1.0,
          // your app's name?
          title: Text(
            'Rating Dialog',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          // encourage your user to leave a high rating?
          message: Text(
            "Tap a star to set your rating. Add more description here if you want.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          // your app's logo?
          // FlutterLogo(size: 100),
          image: Image.asset(AppImageAsset.logo, height: 100, width: 100),
          submitButtonText: 'Submit.',
          submitButtonTextStyle: const TextStyle(
            color: MyColors.secondColor,
            fontWeight: FontWeight.bold,
          ),
          commentHint: 'Set your custom comment hint',
          onCancelled: () => print('Cancelled'),
          onSubmitted: onSubmitted,
          // (response) {
          //   print('=========================================================');
          //   print('rating: ${response.rating}, comment: ${response.comment}');
          //   print('=========================================================');

          //   // ArchieveOrdersController controller = Get.find();
          //   // controller.ratingOrders(
          //   //   ordersId,
          //   //   response.rating,
          //   //   response.comment,
          //   // );
          // },
        ),
  );
}
