// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'package:e_vahak/theme/pallete.dart';

class TicketCard extends StatelessWidget {
  final String source;
  final String destination;
  final int fullSeats;
  final int halfSeats;
  final int price;
  final String tid;
  const TicketCard({
    Key? key,
    required this.source,
    required this.destination,
    required this.fullSeats,
    required this.halfSeats,
    required this.price,
    required this.tid,
  }) : super(key: key);

  void navigateToTicketDetails(BuildContext context) {
    print('is tid null $tid');

    Routemaster.of(context).push('/ticketDetails/$tid');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          navigateToTicketDetails(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Pallete.grey2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$source to $destination',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No. of Seats: ${fullSeats + halfSeats}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Text(
                'Rs. $price',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
