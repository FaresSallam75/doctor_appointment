import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/payment/payment_cubit.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

void customModalBottomSheet(BuildContext context, String doctorId) {
  // final cubit = BlocProvider.of<PaymentCubit>(context);
  final cubit = BlocProvider.of<DoctorCubit>(context);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      // Optional: nice rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        // Ensures content is not hidden by notches/system UI
        child: Wrap(
          // Use Wrap for flexible layout
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.payment_outlined),
              title: const Text('Pay with Card'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Prevent dismissing by tapping outside
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
                FlutterPaymob.instance.payWithCard(
                  context: context,
                  currency: "EGP",
                  amount: double.parse(cubit.doctorData['price'].toString()),

                  onPayment: (response) {
                    context.read<PaymentCubit>().paymentData(
                      myBox!.get("userId"),
                      doctorId,
                      myBox!.get("userName"),
                      myBox!.get("userEmail"),
                      myBox!.get("userPhone"),
                      myBox!.get("userLocation"),
                      "Online Card",
                      "${response.transactionID}",
                      cubit.doctorData['price'].toString(),
                      "EGP",
                      "${response.responseCode}",
                    );

                    Navigator.of(context).pop();
                  },
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallet_giftcard_outlined),
              title: const Text('Pay with Wallet'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Prevent dismissing by tapping outside
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
                FlutterPaymob.instance.payWithWallet(
                  context: context,
                  currency: "EGP",
                  amount: double.parse(cubit.doctorData['price'].toString()),
                  number: myBox!.get("userPhone"), //"01010101010",
                  onPayment: (response) {
                    context.read<PaymentCubit>().paymentData(
                      myBox!.get("userId"),
                      doctorId,
                      myBox!.get("userName"),
                      myBox!.get("userEmail"),
                      myBox!.get("userPhone"),
                      myBox!.get("userLocation"),
                      "Mobile Wallet",
                      "${response.transactionID}",
                      cubit.doctorData['price'].toString(),
                      "EGP",
                      "${response.success}",
                    );
                    // response.success == true
                    //     ? ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(response.message ?? "Successes"),
                    //       ),
                    //     )
                    //     : null;
                    Navigator.of(context).pop();
                  },
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
