import 'package:e_vahak/models/tickets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticketProvider = StateProvider<TicketModel>((ref) => TicketModel(
  source: '',
  destination: '',
  date: '',
  time: '',
  ticketId: '',
  busId: '',
  uid: '',
  price: 0,
  fullSeats: 0,
  halfSeats: 0,
));

class TicketRepository{

  void updateTicketSource(String source,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(source: source));
  }
  void updateTicketDestination(String destination,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(destination: destination));
  }
  void updateTicketDate(String date,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(date: date));
  }
  void updateTicketTime(String time,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(time: time));
  }
  void updateTicketId(String ticketId,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(ticketId: ticketId));
  }
  void updateTicketBusId(String busId,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(busId: busId));
  }
  void updateTicketUid(String uid,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(uid: uid));
  }
  void updateTicketPrice(int price,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(price: price));
  }
  void updateTicketFullSeats(int fullSeats,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(fullSeats: fullSeats));
  }
  void updateTicketHalfSeats(int halfSeats,WidgetRef ref, TicketModel ticket){
    ref.read(ticketProvider.notifier).update((state) => ticket.copyWith(halfSeats: halfSeats));
  }


  
}