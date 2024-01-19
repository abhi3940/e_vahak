import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void naviateToSelectSource(BuildContext context) {
    Routemaster.of(context).push('/selectSource');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'EVahak',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Pallete.grey3),
            onPressed: () {},
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Tickets',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Pallete.grey2,
                  ),
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stop A to Stop B',style: Theme.of(context).textTheme.titleSmall,),
                            const SizedBox(height: 10,),
                            Text('No. of Seats: 2',style: Theme.of(context).textTheme.titleSmall,),
                          ],
                        ),
                        
                        Text('Rs. 100',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),),
                      ],
                    ),
                    
                ),
              ),
              const Spacer(),
              PrimaryButton(
                  title: 'Book Pass', onTapBtn: naviateToSelectSource),
              PrimaryButton(
                  title: 'Book Tickets', onTapBtn: naviateToSelectSource),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
