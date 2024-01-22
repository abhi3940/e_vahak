import 'package:e_vahak/core/common/widgets/password_fields.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/core/common/widgets/text_feilds.dart';
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  String? errorText = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adharnoController = TextEditingController();

  void naviateToLogin(BuildContext context) {
  Routemaster.of(context).push('/login');
}

void naviateToDone(BuildContext context) {
  Routemaster.of(context).push('/done');
}

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthRepository().createUserWithEmailAndPassword(
        ref: ref,
        email: emailController.text,
        password: passwordController.text,
        adharNumber: int.parse(adharnoController.text),
      );
    } on FirebaseAuthException {
      setState(() {
        errorText = 'Something went wrong';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                  onPressed: () {
                    naviateToLogin(context);
                  },
                  child: Text(
                    'Log In',
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
              CustomTextFeilds(hint: 'Name', controller: nameController),
              CustomTextFeilds(
                hint: 'E-Mail',
                controller: emailController,
              ),
              CustomTextFeilds(
                hint: 'Aadhar-card Number',
                controller: adharnoController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              PasswordField(
                hint: 'Password',
                controller: passwordController,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    naviateToLogin(context);
                  },
                  child: Text('Already have an Account?',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(
                  title: 'Sign Up',
                  onTapBtn: () async{
                    if (kDebugMode) {
                      print('start');
                    }
                    await createUserWithEmailAndPassword();
                    if (kDebugMode) {
                      print('done');
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}