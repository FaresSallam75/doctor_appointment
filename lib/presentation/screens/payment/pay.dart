// import 'dart:io';
// import 'package:flutter/material.dart';

// class PaymentOnline extends StatelessWidget {
//   const PaymentOnline({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     String os = Platform.operatingSystem;

//     var applePayButton = ApplePayButton(
//       paymentConfiguration: PaymentConfiguration.fromJsonString(
//         defaultApplePay,
//       ),
//       paymentItems: const [
//         PaymentItem(
//           label: 'Item A',
//           amount: '0.01',
//           status: PaymentItemStatus.final_price,
//         ),
//         PaymentItem(
//           label: 'Item B',
//           amount: '0.01',
//           status: PaymentItemStatus.final_price,
//         ),
//         PaymentItem(
//           label: 'Total',
//           amount: '0.02',
//           status: PaymentItemStatus.final_price,
//         ),
//       ],
//       style: ApplePayButtonStyle.black,
//       width: double.infinity,
//       height: 50,
//       type: ApplePayButtonType.buy,
//       margin: const EdgeInsets.only(top: 15.0),
//       onPaymentResult: (result) => debugPrint('Payment Result $result'),
//       loadingIndicator: const Center(child: CircularProgressIndicator()),
//     );

//     var googlePayButton = GooglePayButton(
//       onError: (error) {
//         Get.back();
//       },
//       paymentConfiguration: PaymentConfiguration.fromJsonString(
//         defaultGooglePay,
//       ),
//       paymentItems: const [
//         PaymentItem(
//           label: 'Item A',
//           amount: '0.01',
//           status: PaymentItemStatus.final_price,
//         ),
//         PaymentItem(
//           label: 'Item B',
//           amount: '0.01',
//           status: PaymentItemStatus.final_price,
//         ),
//         PaymentItem(
//           label: 'Total',
//           amount: '0.02',
//           status: PaymentItemStatus.final_price,
//         ),
//       ],
//       type: GooglePayButtonType.pay,
//       margin: const EdgeInsets.only(top: 15.0),
//       onPaymentResult: (result) => debugPrint('Payment Result $result'),
//       loadingIndicator: const Center(child: CircularProgressIndicator()),
//     );

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
//       ),
//     );
//   }
// }
