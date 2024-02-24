import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_vahak/core/providers/firebase_providers.dart';
import 'package:e_vahak/features/auth/controller/auth_controller.dart';
import 'package:e_vahak/models/tickets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTicketProvider = StreamProvider((ref) {
  final uid = ref.watch(userIdProvider);
  return ref.read(ticketRepositoryProvider).getTickets(uid);
});

final getBusTicketProvider = StreamProvider((ref) {
  return ref.read(ticketRepositoryProvider).getTickets('');
});

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepository(firestore: ref.read(firestoreProvider));
});

final ticketProvider = StateProvider<TicketModel>((ref) {
  final uid = ref.watch(userIdProvider);
  return TicketModel(
    source: '',
    destination: '',
    date: '',
    time: DateTime.now().toString(),
    ticketId: '',
    busId: '',
    uid: uid,
    price: 0,
    fullSeats: 0,
    halfSeats: 0,
    createdAt: DateTime.now(),
  );
});

class TicketRepository {
  final FirebaseFirestore _firestore;
  TicketRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _tickets => _firestore.collection('tickets');

  Future<void> addTicket(TicketModel ticket) async {
    try {
      await _tickets.add(ticket.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Stream<List<TicketModel>> getTickets(String uid) {
    return _tickets
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => TicketModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Stream<List<TicketModel>> getBusTickets(String busId) {
    return _tickets
        .where('busId', isEqualTo: busId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => TicketModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

}
