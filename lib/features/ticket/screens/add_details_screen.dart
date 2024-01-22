import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/models/tickets.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';

class PassengerDetails extends ConsumerStatefulWidget {
  const PassengerDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PassengerDetailsState();
}

class _PassengerDetailsState extends ConsumerState<PassengerDetails> {
  void naviateToConformation(BuildContext context) {
    Routemaster.of(context).push('/confirmation');
  }

  void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
  }

  void updateTicket(TicketModel ticket, WidgetRef ref, int full, int half) {
    ref.read(ticketProvider.notifier).update(
          (state) => ticket.copyWith(fullSeats: full, halfSeats: half),
        );
  }

  final List<String> detailList = ["Full Tickets", "Half Tickets"];
  final divide = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Divider(
      color: Pallete.grey3,
      thickness: 1,
    ),
  );

  final TextEditingController _fullTicketsController =
      TextEditingController(text: '00');
  final TextEditingController _halfTicketsController =
      TextEditingController(text: '00');
  bool isTextFieldEnabled = false;

  // void _incrementValue(TextEditingController controller) {
  //   int value = int.parse(controller.text);
  //   if (value < 10) {
  //     setState(() {
  //       controller.text = (value + 1).toString();
  //     });
  //   }
  // }

  // void _decrementValue(TextEditingController controller) {
  //   int value = int.parse(controller.text);
  //   if (value > 0) {
  //     setState(() {
  //       controller.text = (value - 1).toString();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(ticketProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ticket Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Pallete.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Pallete.grey3),
          onPressed: () => navigateToHome(context),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          _buildDetails(
              detail: detailList[0], controller: _fullTicketsController),
          divide,
          _buildDetails(
              detail: detailList[1], controller: _halfTicketsController),
          divide,
          const Spacer(
            flex: 4,
          ),
          PrimaryButton(
            title: "Done",
            onTapBtn: () {
              
                
                   ref.read(ticketProvider.notifier).update(
          (state) => ticket.copyWith(fullSeats: int.parse(_fullTicketsController.text), halfSeats: int.parse(_halfTicketsController.text)),
        );
                
              
              naviateToConformation(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _buildDetails(
      {required String detail, required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            detail,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  int value = int.parse(controller.text);
                  if (value > 0) {
                    setState(() {
                      controller.text = (value - 1).toString();
                    });
                  }
                },
                icon: const Icon(Icons.remove_circle),
                color: Pallete.primaryColor,
                iconSize: 32,
              ),
              SizedBox(
                width: 100,
                height: 60,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  enabled: isTextFieldEnabled,
                ),
              ),
              IconButton(
                onPressed: () {
                  int value = int.parse(controller.text);
                  if (value < 10) {
                    setState(() {
                      controller.text = (value + 1).toString();
                    });
                  }
                },
                icon: const Icon(Icons.add_circle),
                color: Pallete.primaryColor,
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
