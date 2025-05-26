// import 'package:flutter/material.dart';

// class PayPalOnline extends StatelessWidget {
//   const PayPalOnline({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PaypalCheckout(
//       sandboxMode: true,
//       clientId:
//           "AbgtKOV-C0smtlZNJQSvQSb7sA6R27uwtpTt8aN6RXp0UAQ98-Mnt9Mptbr1Yr2qFvob_EnPwYJmQUfo",
//       secretKey:
//           "ENXq1VeMYUQ2YjKRYL-bu2jk3VujKhQI4rpvuY-MSUa4bfaFF4wmnwJtMwd-kZqyMBXiZfTjw-s1Mekt",
//       returnURL: "success.snippetcoder.com",
//       cancelURL: "cancel.snippetcoder.com",
//       transactions: const [
//         {
//           "amount": {
//             "total": "50", //'${controller.getTotalPrice}',
//             "currency": "USD",
//             "details": {
//               "subtotal": "50", //'${controller.getTotalPrice}',
//               "shipping": '0',
//               "shipping_discount": 0,
//             },
//           },
//           "description": "The payment transaction description.",
//           // "payment_options": {
//           //   "allowed_payment_method":
//           //       "INSTANT_FUNDING_SOURCE"
//           // },
//           "item_list": {
//             "items": [
//               // {"name": "Apple", "quantity": 4, "price": '5', "currency": "USD"},
//               {
//                 "name": "Pineapple",
//                 "quantity": 5,
//                 "price": '10',
//                 "currency": "USD",
//               },
//             ],

//             // shipping address is not required though
//             //   "shipping_address": {
//             //     "recipient_name": "Raman Singh",
//             //     "line1": "Delhi",
//             //     "line2": "",
//             //     "city": "Delhi",
//             //     "country_code": "IN",
//             //     "postal_code": "11001",
//             //     "phone": "+00000000",
//             //     "state": "Texas"
//             //  },
//           },
//         },
//       ],
//       note: "Contact us for any questions on your order.",
//       onSuccess: (Map params) async {
//         print(
//           "list: ========================================== ${params.entries.toList()} ",
//         );
//         print(
//           "email: =================================== ${params['data']['payer']['payer_info']['email']} ",
//         );
//         print(
//           "email: =================================== ${params['data']['payer']['payer_info']['first_name']} ",
//         );
//         print(
//           "email: =================================== ${params['data']['payer']['payer_info']['last_name']} ",
//         );

//         print(
//           "payment_method: =================================== ${params['data']['payer']['payment_method']} ",
//         );
//         print(
//           "status: =================================== ${params['data']['payer']['status']} ",
//         );
//         print(
//           "payer_id: =================================== ${params['data']['payer']['payer_info']['payer_id']}",
//         );
//         print(
//           "amount: =================================== ${params['data']['transactions'][0]['amount']['total']} + ${params['data']['payer']['payer_info']['shipping_address']['country_code']} ",
//         );
//         print(
//           "currency: =================================== ${params['data']['transactions'][0]['amount']['currency']}  ",
//         );
//         controller.accountId =
//             params['data']['payer']['payer_info']['payer_id'];

//         controller.name =
//             params['data']['payer']['payer_info']['first_name'] +
//             params['data']['payer']['payer_info']['last_name'];

//         controller.email = params['data']['payer']['payer_info']['email'];

//         controller.method = params['data']['payer']['payment_method'];

//         controller.status = params['data']['payer']['status'];

//         controller.amount =
//             "${params['data']['transactions'][0]['amount']['total']}";

//         controller.countryCode =
//             params['data']['payer']['payer_info']['shipping_address']['country_code'];
//         controller.currency =
//             params['data']['transactions'][0]['amount']['currency'];

//         controller.checkout();
//       },
//       onError: (error) {
//         print("onError:============================ $error");
//         // Navigator.pop(context);
//         Get.back();
//       },
//       onCancel: () {
//         print('cancelled: ===================================');
//       },
//     );
//   }
// }
