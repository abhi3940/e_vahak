import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class PaymentGateScreen extends StatefulWidget {
  final String result;
  const PaymentGateScreen({super.key, required this.result});

  @override
  State<PaymentGateScreen> createState() => _PaymentGateScreenState();
}

class _PaymentGateScreenState extends State<PaymentGateScreen> {
  void navigateToConfirmation(BuildContext context) {
    Routemaster.of(context).push('/confirmation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Scan Result: ${widget.result}"),
            PrimaryButton(
              title: "Done",
              onTapBtn: navigateToConfirmation,
            ),
          ],
        ),
      ),
    );
  }
}
