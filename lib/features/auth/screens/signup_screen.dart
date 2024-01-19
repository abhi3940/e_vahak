import 'package:e_vahak/core/common/widgets/password_fields.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/core/common/widgets/text_feilds.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  void NaviateToLogin(BuildContext context) {
    Routemaster.of(context).push('/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    NaviateToLogin(context);
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
              const CustomTextFeilds(hint: 'Name'),
              const CustomTextFeilds(hint: 'Mobile Number'),
              const CustomTextFeilds(hint: 'Aadhar-card Number'),
              const PasswordField(hint: 'Password'),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    NaviateToLogin(context);
                  },
                  child: Text('Already have an Account?',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(title: 'Sign Up', onTapBtn: NaviateToLogin),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
