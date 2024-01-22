import 'package:e_vahak/models/tickets.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:routemaster/routemaster.dart';

class Confirm extends ConsumerWidget {
  const Confirm({Key? key}) : super(key: key);
  int calculatePrice(int full, int half) {
    return (full * 20) + (half * 10);
  }

  void navigateToHome(BuildContext context) {
    Routemaster.of(context).push('/home');
  }

  void updateTicketPrice(int price, WidgetRef ref, TicketModel ticket) {
    ref
        .read(ticketProvider.notifier)
        .update((state) => ticket.copyWith(price: price));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ref.watch(ticketProvider);
    int price = calculatePrice(ticket.fullSeats, ticket.halfSeats);
    Future(() {
      updateTicketPrice(price, ref, ticket);
    });
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
                      // Add your payment logic here
                      navigateToHome(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Pallete.primaryColor,
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
}
