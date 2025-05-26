import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

class FlutterPaymobTest extends StatefulWidget {
  const FlutterPaymobTest({super.key});

  @override
  State<FlutterPaymobTest> createState() => _FlutterPaymobTestState();
}

class _FlutterPaymobTestState extends State<FlutterPaymobTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Paymob Test"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                FlutterPaymob.instance.payWithCard(
                  context: context,
                  currency: "EGP",
                  amount: 100,
                  onPayment: (response) {
                    response.success == true
                        ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.message ?? "Successes"),
                          ),
                        )
                        : null;
                  },
                );
              },
              child: const Text("Pay with card"),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterPaymob.instance.payWithWallet(
                  context: context,
                  currency: "EGP",
                  amount: 100,
                  number: "01010101010",
                  onPayment: (response) {
                    response.success == true
                        ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.message ?? "Successes"),
                          ),
                        )
                        : null;
                  },
                );
              },
              child: const Text("Pay With Wallet"),
            ),
          ],
        ),
      ),
    );
  }
}
