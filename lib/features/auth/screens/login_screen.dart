import 'package:e_vahak/core/common/widgets/password_fields.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/core/common/widgets/text_feilds.dart';
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
    String? errorText = '';
  bool isLogin = true;

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> signInWithEmailPassword() async {
    try {
      await AuthRepository().signInWithEmailAndPassword(
        email: mobileNumberController.text,
        password: passwordController.text,
        ref: ref,
      );
      return true; // Sign-in successful
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errorText = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorText = 'Wrong password provided for that user.';
        });
      }
      return false; // Sign-in failed
    }
  }
  void naviateToSignUp(BuildContext context) {
  Routemaster.of(context).push('/signup');
}


void naviateToDone(BuildContext context) {
  Routemaster.of(context).push('/done');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Log In',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                  onPressed: () {
                    naviateToSignUp(context);
                  },
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              CustomTextFeilds(
                hint: 'Mobile Number',
                controller: mobileNumberController,
              ),
              PasswordField(
                hint: 'Password',
                controller: passwordController,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(
                  title: 'Log In',
                  onTapBtn: () async {
                     await signInWithEmailPassword();
                    
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
