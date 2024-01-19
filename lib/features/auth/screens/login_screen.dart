import 'package:e_vahak/core/common/widgets/password_fields.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/core/common/widgets/text_feilds.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void NaviateToSignUp(BuildContext context) {
    Routemaster.of(context).push('/signup');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    NaviateToSignUp(context);
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
              const CustomTextFeilds(hint: 'Mobile Number'),
              const PasswordField(hint: 'Password'),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?',
                      style: Theme.of(context).textTheme.bodySmall)),
              PrimaryButton(title: 'Log In', onTapBtn: NaviateToSignUp),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
