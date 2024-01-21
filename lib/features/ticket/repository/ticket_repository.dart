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
  
}