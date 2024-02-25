import 'package:e_vahak/features/home/screens/drawer.dart';
import 'package:e_vahak/features/home/screens/ticket_card.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Vahak',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              icon: const Icon(Icons.menu, color: Pallete.grey3),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current Bus Tickets',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
            ref.watch(getBusTicketProvider).when(
                data: (ticket) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: ticket.length,
                        itemBuilder: (context, index) {
                          print(ticket[index].ticketId);
                          print(ticket[index].price);
                          return TicketCard(
                            source: ticket[index].source,
                            destination: ticket[index].destination,
                            fullSeats: ticket[index].fullSeats,
                            halfSeats: ticket[index].halfSeats,
                            price: ticket[index].price,
                            tid: ticket[index].ticketId,
                          );
                        }),
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stackTrace) {
                  if (kDebugMode) {
                    print(error.toString());
                    print(stackTrace.toString());
                  }

                  return Center(
                    child: Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
