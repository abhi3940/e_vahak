import 'package:flutter/material.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';


class Ticket extends StatelessWidget {
  const Ticket({Key? key}) : super(key: key);

  void navigateToHome(BuildContext context) {
    Routemaster.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "Ticket Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
          Positioned(
            top: 252,
            left: 28,
            child: Card(
              margin: const EdgeInsets.all(0), 
              color: Pallete.grey, 
              elevation: 0, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                
                child: const Padding(
                  padding:  EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("No: 0000956          06-10-24            14:58:47"),
                      SizedBox(height: 24), 
                      Center(child: Text("Stop A     To     Stop B")),
                      SizedBox(height: 24),
                      Text("Full : 1  X  20.00 = Rs. 20.00"),
                      Text("Booked by: User A"),
                      SizedBox(height: 24),
                      Center(child: Text("Rs. 20.00")),
                      SizedBox(height: 24),

                      Center(child: Text("NOT TRANSFERABLE")),
                      Center(child: Text("HELPLINE : 1000-88-6969")),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                navigateToHome(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(15, 163, 210, 1),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
