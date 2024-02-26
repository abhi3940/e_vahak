import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:e_vahak/models/tickets.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:routemaster/routemaster.dart';

class ConfirmationForPass extends ConsumerStatefulWidget {
  const ConfirmationForPass({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmationForPassState();
}





class _ConfirmationForPassState extends ConsumerState<ConfirmationForPass> {
  void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
}

void navigateToSuccess(BuildContext context) {
    Routemaster.of(context).push('/success');
  }

  void addTicket() {
    TicketModel ticket = ref.watch(ticketProvider.notifier).update((state) => state.copyWith(
      createdAt: DateTime.now(),
      price: 50,
      source: 'PASS',
      fullSeats: 1,
    ));
    ref.read(ticketRepositoryProvider).addTicket(ticket);
  }

  @override
  Widget build(BuildContext context) {
    var price = 50;
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Rs. $price",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Your pass will be valid till 12:00 PM",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  
                  PrimaryButton(
                      title: 'Pay',
                      onTapBtn: () {
                        openCheckout(price);
                      }),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        navigateToHome(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Pallete.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  late Razorpay _razorpay;

  void openCheckout(amount) async {
    final user = ref.read(userProvider);
    final ticket = ref.watch(ticketProvider);
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_XmpG9DGEHl7iYz',
      'name': 'E-vahak',
      'description': '${ticket.source} to ${ticket.destination} ${ticket.fullSeats+ticket.halfSeats} Seats',
      'prefill': {'contact': '7410189576', 'email': user?.email, 'route': '${ticket.source} to ${ticket.destination}' , 'number of seats':ticket.fullSeats+ticket.halfSeats },
      "amount": amount,
      "timeout": 60,
      "external": {
        'wallets': ['paytm', 'upi']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) {
    navigateToSuccess(context);
    addTicket();

    Fluttertoast.showToast(
        msg: "Payment Successful ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
}