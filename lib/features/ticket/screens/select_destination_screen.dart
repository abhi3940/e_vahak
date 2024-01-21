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
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectDestinationScreenState();
}

class _SelectDestinationScreenState extends ConsumerState<SelectDestinationScreen> {
  int selectedRadio = 0;
  void naviateToAddTicketDetails(BuildContext context) {
    Routemaster.of(context).push('/addticketDetails');
  }

  @override
  Widget build(BuildContext context) {
    selectedRadio = widget.selectedSource+1;
    final ticket = ref.watch(ticketProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Destination',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Pallete.grey3),
            onPressed: () => Routemaster.of(context).pop(),
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
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                    ),
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
                            : Container(
                                padding: const EdgeInsets.all(16.0)
                                    .copyWith(top: 0, bottom: 0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: index,
                                              groupValue: selectedRadio,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadio = value as int;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            stops[index]['name'] as String,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Pallete.grey3,
                                        thickness: 1,
                                      ),
                                    ]),
                              );
                      })),
              TextButton(
                  onPressed: () {},
                  child: Text(
                      'Selected Source:${stops[widget.selectedSource]['name']}',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(
                  title: 'Next',
                  onTapBtn: () {
                    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(
                        destination: stops[selectedRadio]['name'] as String));
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
