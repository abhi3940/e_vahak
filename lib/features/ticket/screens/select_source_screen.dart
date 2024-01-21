import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/models/stops.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';

class SelectSourceScreen extends ConsumerStatefulWidget {
  const SelectSourceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectSourceScreenState();
}

class _SelectSourceScreenState extends ConsumerState<SelectSourceScreen> {
  int selectedRadio = 0;
  void naviateToSelectDestination(BuildContext context) {
    Routemaster.of(context).push('/selectDestination/$selectedRadio');
  }
  void navigateToHome(BuildContext context) {
    Routemaster.of(context).push('/home');
  }

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(ticketProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Source',
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
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 8), // Adjust the vertical padding here
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
                        return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 33,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left:8.0,right: 8.0),
                                  child: Divider(color: Pallete.grey3,),
                                )
                              ]),
                        );
                      })),
              PrimaryButton(
                  title: 'Next',
                  onTapBtn: () {
                    ref.read(ticketProvider.notifier).update((state) =>
                        ticket.copyWith(
                            source: stops[selectedRadio]['name'] as String));
                    naviateToSelectDestination(context);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
