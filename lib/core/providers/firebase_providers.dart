import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provider for Firestore. Returns the same instance of FirebaseFirestore.
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

// Provider for FirebaseAuth. Returns the same instance of FirebaseAuth.
final authProvider = Provider((ref) => FirebaseAuth.instance);