import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:e_vahak/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Pallete.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle, 
                      color:Pallete.primaryColor,
                      size: 178.0, 
                    ),
                    SizedBox(height: 16),
                    Text('Thank you!', style:TextStyle(color: Pallete.primaryColor , fontSize: 30)),
                    SizedBox(height: 4),
                    Text('Tickets Booked Successfully!', style:TextStyle(color: Pallete.grey3 , fontSize: 16)),
                    SizedBox(height: 8),
                    
                  ],
                ),
              ),
            ),
            PrimaryButton(title: 'Done', onTapBtn: () => navigateToHome(context)),
            const SizedBox(height: 20),
                    
          ],
        ),
      ),
     

    );
  }
}
