import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

// Text("No: 0000956          06-10-24            14:58:47",),
// SizedBox(height: 24),
// Center(child: Text("Stop A     To     Stop B")),
// SizedBox(height: 24),
// Text("Full : 1  X  20.00 = Rs. 20.00"),
// Text("Booked by: User A"),
// SizedBox(height: 24),
// Center(child: Text("Rs. 20.00")),
// SizedBox(height: 24),

// Center(child: Text("NOT TRANSFERABLE")),
// Center(child: Text("HELPLINE : 1000-88-6969")),

class Ticket extends ConsumerWidget {
  final String tid;
  const Ticket({super.key, required this.tid});

  void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ref.watch(getTicketByIdProvider(tid)).value;
    final date = ticket?.time;
    final stops = '${ticket?.source}     To     ${ticket?.destination}';
    final full =
        'Full : ${ticket?.fullSeats}  X  20.00 = Rs. ${(ticket?.fullSeats ?? 1) * 20}';
    final half =
        'Half : ${ticket?.halfSeats}  X  10.00 = Rs. ${(ticket?.halfSeats ?? 1) * 10}';
    final price = 'Rs. ${ticket?.price}';

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ticket Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 300,
                color: Pallete.grey2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    
                        Text(
                          date?.toString() ?? '',
                          style: const TextStyle(color: Colors.black),
                        ),
                      
                    const SizedBox(
                      height: 24,
                    ),
                    Center(child: Text(stops,style: const TextStyle(color: Colors.black),)),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(full,style: const TextStyle(color: Colors.black),),
                    Text(half,style: const TextStyle(color: Colors.black),),
                    const SizedBox(
                      height: 24,
                    ),
                    Center(child: Text(price,style: const TextStyle(color: Colors.black),)),
                    const SizedBox(
                      height: 24,
                    ),
                    const Center(child: Text("NOT TRANSFERABLE",style: TextStyle(color: Colors.black),)),
                    const Center(child: Text("HELPLINE : 1000-88-6969",style: TextStyle(color: Colors.black),)),
                  ]),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            PrimaryButton(
              title: 'Done',
              onTapBtn: () => navigateToHome(context),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
