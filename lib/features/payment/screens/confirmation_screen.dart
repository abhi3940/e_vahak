import 'package:e_vahak/models/tickets.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:routemaster/routemaster.dart';

class Confirm extends ConsumerStatefulWidget {
  const Confirm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmState();
}

class _ConfirmState extends ConsumerState<Confirm> {
  int calculatePrice(int full, int half) {
    return (full * 20) + (half * 10);
  }

  void navigateToHome(BuildContext context) {
    Routemaster.of(context).push('/home');
  }

  void navigateToSuccess(BuildContext context) {
    Routemaster.of(context).push('/success');
  }

  void updateTicketPrice(int price, WidgetRef ref, TicketModel ticket) {
    Future() {
      ref
          .read(ticketProvider.notifier)
          .update((state) => ticket.copyWith(price: price));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(ticketProvider);
    int price = calculatePrice(ticket.fullSeats, ticket.halfSeats);
    updateTicketPrice(price, ref, ticket);
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
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
                  Text("From: ${ticket.source}",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text("To: ${ticket.destination}",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text("No. of Full Seats: ${ticket.fullSeats} ",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text("No. of Half Seats: ${ticket.halfSeats} ",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      openCheckout(ticket.price);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(15, 163, 210, 1),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Pay"),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        navigateToHome(context);
                      },
                      style: TextButton.styleFrom(
                        primary: Color.fromRGBO(15, 163, 210, 1),
                      ),
                      child: const Text("Cancel"),
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
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_XmpG9DGEHl7iYz',
      'name': 'E-vahak',
      'description': 'PMPML',
      'prefill': {'contact': '7887886615', 'email': 'ganeshs.0520@gmail.com'},
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    navigateToSuccess(context);
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
