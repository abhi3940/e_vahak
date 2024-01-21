// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TicketModel {
  final String source;
  final String destination;
  final int fullSeats ;
  final int halfSeats ;
  final String date;
  final String time;
  final String ticketId;
  final String busId;
  final String uid;
  final int price;
  TicketModel({
    required this.source,
    required this.destination,
    required this.date,
    required this.time,
    required this.ticketId,
    required this.busId,
    required this.uid,
    required this.price,
    required this.fullSeats,
    required this.halfSeats,
  });

  TicketModel copyWith({
    String? source,
    String? destination,
    String? date,
    String? time,
    String? ticketId,
    String? busId,
    String? uid,
    int? price,
    int? fullSeats,
    int? halfSeats,
  }) {
    return TicketModel(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      date: date ?? this.date,
      time: time ?? this.time,
      ticketId: ticketId ?? this.ticketId,
      busId: busId ?? this.busId,
      uid: uid ?? this.uid,
      price: price ?? this.price,
      fullSeats: fullSeats ?? this.fullSeats,
      halfSeats: halfSeats ?? this.halfSeats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source,
      'destination': destination,
      'date': date,
      'time': time,
      'ticketId': ticketId,
      'busId': busId,
      'uid': uid,
      'price': price,
      'fullSeats': fullSeats,
      'halfSeats': halfSeats,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      source: map['source'] as String,
      destination: map['destination'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      ticketId: map['ticketId'] as String,
      busId: map['busId'] as String,
      uid: map['uid'] as String,
      price: map['price'] as int,
      fullSeats: map['fullSeats'] as int,
      halfSeats: map['halfSeats'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketModel.fromJson(String source) => TicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketModel(source: $source, destination: $destination, date: $date, time: $time, ticketId: $ticketId, busId: $busId, uid: $uid, price: $price)';
  }

  @override
  bool operator ==(covariant TicketModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.source == source &&
      other.destination == destination &&
      other.date == date &&
      other.time == time &&
      other.ticketId == ticketId &&
      other.busId == busId &&
      other.uid == uid &&
      other.price == price;
      
  }

  @override
  int get hashCode {
    return source.hashCode ^
      destination.hashCode ^
      date.hashCode ^
      time.hashCode ^
      ticketId.hashCode ^
      busId.hashCode ^
      uid.hashCode ^
      price.hashCode ^
      fullSeats.hashCode ^
      halfSeats.hashCode;
  }
}
