// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String uid;
  final int adharNumber;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.adharNumber,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? uid,
    int? adharNumber,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      adharNumber: adharNumber ?? this.adharNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'adharNumber': adharNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      adharNumber: map['adharNumber'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, uid: $uid, adharNumber: $adharNumber)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.uid == uid &&
      other.adharNumber == adharNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      uid.hashCode ^
      adharNumber.hashCode;
  }
}
