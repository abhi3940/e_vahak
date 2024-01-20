
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_vahak/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required int adharNumber,
  }) async {
    try {
      if (adharNumber.toString().length != 12) {
        throw Exception('Adhar number should be 12 digits');
      }
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user?.uid ?? '';
      UserModel userModel = UserModel(
        name: 'name',
        email: email,
        password: password,
        uid: uid,
        adharNumber: 0,
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Add the user model to Firestore
      await users.doc(uid).set(userModel.toMap());


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e);
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
