import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/features/payment/screens/gateway_screen.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  void navigateToSelectSource(BuildContext context) {
    Routemaster.of(context).push('/selectSource');
  }

  // void navigateToQRScreen(BuildContext context) {
  //   Routemaster.of(context).push('/scanQR');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Vahak',
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
                  title: 'Book Pass', onTapBtn: navigateToSelectSource),
              PrimaryButton(
                  title: 'Book Tickets', onTapBtn: navigateToSelectSource),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }  


  // Qr Scanning Code
  
  String _qrScanRes = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint(qrScanRes);
    } on PlatformException {
      qrScanRes = "Failed to get platform version.";
    }
    if (!mounted) return;

    setState(() {
      _qrScanRes = qrScanRes;
    });

    // Navigate to a new page with the result
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentGateScreen(result: _qrScanRes),
      ),
    );
  }
}
