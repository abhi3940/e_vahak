import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:e_vahak/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);



final authContollerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

// Provider for auth state changes. It uses StreamProvider to listen to the auth state changes.
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authContollerProvider.notifier);
  return authController.authStateChanges;
});

class AuthController extends StateNotifier<bool> {
  // Private instance of AuthRepository.
  final AuthRepository _authRepository;
  // Private instance of Ref.
  final Ref _ref;

  // Constructor for AuthController. It takes instances of AuthRepository and Ref as arguments.
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  // Getter for auth state changes stream from AuthRepository.
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  //method to sign in with email and password whith bool for loading
  void signInWithEmailAndPassword(email,password)async{
    state = true;
    final user = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    state = false;
    _ref.read(userProvider.notifier).update((state) => user);
  }

  // Method to create user with email and password. It calls the createUserWithEmailAndPassword method from the AuthRepository.
  void createUserWithEmailAndPassword(email,password,adharNumber)async{
    state = true;
    final user = await _authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
      adharNumber: adharNumber,
    );
    state = false;
    _ref.read(userProvider.notifier).update((state) => user );
  }

  
  // Method to get user data. It calls the getUserData method from the AuthRepository.
  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  // Method to sign out. It calls the signOut method from the AuthRepository.
  void logOut() async {
     _authRepository.signOut();
  }
}
