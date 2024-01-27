// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void navigateToSelectSource(BuildContext context) {
    Routemaster.of(context).push('/selectSource');
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  // void navigateToQRScreen(BuildContext context) {
  //   Routemaster.of(context).push('/scanQR');
  // }

  // Qr Scanning Code

  String qrScanRes = '';

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
      qrScanRes = qrScanRes;
    });

    // Navigate to a new page with the result
    navigateToSelectSource(context);
  }

  @override
  Widget build(BuildContext context) {
  //print(ref.read(authRepositoryProvider).currentUser);
  //print(ref.read(userIdprovider));
  //print('hello');


    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Vahak',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
              icon: const Icon(Icons.menu, color: Pallete.grey3),
              onPressed: ()=> Scaffold.of(context).openDrawer() ),
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
              ref.watch(getTicketProvider).when(
                  data: (ticket) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: ticket.length,
                          itemBuilder: (context, index) {
                            return TicketCard(
                              source: ticket[index].source,
                              destination: ticket[index].destination,
                              fullSeats: ticket[index].fullSeats,
                              halfSeats: ticket[index].halfSeats,
                              price: ticket[index].price,
                            );
                          }),
                    );
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    }

                    return Center(
                      child: Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    );
                  }),
              PrimaryButton(
                  title: 'Book Pass',
                  onTapBtn: () {
                    scanQR();
                  }),
              PrimaryButton(
                  title: 'Book Tickets',
                  onTapBtn: () => navigateToSelectSource(context)),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        drawer: const MainDrawer());
  }
}

class TicketCard extends StatelessWidget {
  final String source;
  final String destination;
  final int fullSeats;
  final int halfSeats;
  final int price;
  const TicketCard({
    Key? key,
    required this.source,
    required this.destination,
    required this.fullSeats,
    required this.halfSeats,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Pallete.grey2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$source to $destination',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No. of Seats: ${fullSeats + halfSeats}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Text(
              'Rs. $price',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: SafeArea(
            child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            ref.read(authRepositoryProvider).signOut(ref);
          },
        ),
      ],
    )));
  }
}
