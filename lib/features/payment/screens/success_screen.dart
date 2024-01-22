import 'package:flutter/material.dart';

import 'package:e_vahak/theme/pallete.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Pallete.backgroundColor,
      body: Column(
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
                  Text('Tickets Booked Successfully!'),
                  SizedBox(height: 8),
                  
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your logic here
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child:const  Text("Done"),
            
          ),
          SizedBox(height: 32),
                  
        ],
      ),
     

    );
  }
}
