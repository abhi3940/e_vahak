import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/models/stops.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';

class SelectDestinationScreen extends ConsumerStatefulWidget {
  final int selectedSource;
  const SelectDestinationScreen({super.key, required this.selectedSource});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectDestinationScreenState();
}

class _SelectDestinationScreenState
    extends ConsumerState<SelectDestinationScreen> {
  int selectedRadio = stops.length - 1;
  void naviateToAddTicketDetails(BuildContext context) {
    Routemaster.of(context).push('/addticketDetails');
  }
  void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(ticketProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Destination',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Pallete.grey3),
            onPressed: () => navigateToHome(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Pallete.grey3,
                      ),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    filled: true,
                    fillColor: Pallete.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: stops.length,
                      itemBuilder: (context, index) {
                        return widget.selectedSource >= index
                            ? Container()
                            : Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 33,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Radio(
                                          value: index,
                                          groupValue: selectedRadio,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedRadio = value as int;
                                            });
                                          },
                                        ),
                                        Text(
                                          stops[index]['name'] as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(
                                      color: Pallete.grey3,
                                    ),
                                  )
                                ]);
                      })),
              TextButton(
                  onPressed: () {},
                  child: Text(
                      'Selected source: ${stops[widget.selectedSource]['name']}',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(
                  title: 'Next',
                  onTapBtn: () {
                    ref.read(ticketProvider.notifier).update((state) =>
                        ticket.copyWith(
                            destination:
                                stops[selectedRadio]['name'] as String));
                    naviateToAddTicketDetails(context);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
