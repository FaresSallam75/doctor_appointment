// import 'package:flutter/material.dart';
// import 'package:paymob_payment/paymob_payment.dart';

// class PaymentView extends StatefulWidget {
//   const PaymentView({super.key});

//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }

// class _PaymentViewState extends State<PaymentView> {
//   PaymobResponse? response;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Paymob')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.network('https://paymob.com/images/logoC.png'),
//             const SizedBox(height: 24),
//             if (response != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text("Success ==> ${response?.success}"),
//                   const SizedBox(height: 8),
//                   Text("Transaction ID ==> ${response?.transactionID}"),
//                   const SizedBox(height: 8),
//                   Text("Message ==> ${response?.message}"),
//                   const SizedBox(height: 8),
//                   Text("Response Code ==> ${response?.responseCode}"),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ElevatedButton(
//               child: const Text('Pay for 200 EGP'),
//               onPressed:
//                   () => PaymobPayment.instance.pay(
//                     context: context,
//                     currency: "EGP",
//                     amountInCents: "20000",
//                     onPayment:
//                         (response) => setState(() => this.response = response),
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
