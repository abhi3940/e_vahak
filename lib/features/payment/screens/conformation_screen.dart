import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class Confirm extends StatelessWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Rs.40",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("From: Stop A", style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8),
                  Text("To: Stop B", style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8),
                  Text("No. of Seats: 1", style:Theme.of(context).textTheme.titleSmall ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Add your payment logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(15, 163, 210, 1),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Pay"),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Add your cancel logic here
                      },
                      style: TextButton.styleFrom(
                        primary: Color.fromRGBO(15, 163, 210, 1),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Routemaster.of(context).pop();
                          },
                          child: Text("Cancel")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
