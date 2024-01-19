import 'package:e_vahak/core/common/widgets/password_fields.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/core/common/widgets/text_feilds.dart';
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void naviateToLogin(BuildContext context) {
  Routemaster.of(context).push('/login');
}
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorText = '';
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adharnoController = TextEditingController();


  Future<void> createUserWithEmailAndPassword() async{
    try{
      await AuthRepository().createUserWithEmailAndPassword(
        email: mobileNumberController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException{
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
               CustomTextFeilds(hint: 'Mobile Number', controller: mobileNumberController,),
               CustomTextFeilds(hint: 'Aadhar-card Number', controller: adharnoController,),
               PasswordField(hint: 'Password', controller: passwordController,),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    naviateToLogin(context);
                  },
                  child: Text('Already have an Account?',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(title: 'Sign Up', onTapBtn: naviateToLogin),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}