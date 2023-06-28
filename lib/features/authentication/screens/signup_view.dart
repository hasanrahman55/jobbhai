import 'package:flutter/material.dart';
import 'package:jobbhai/features/authentication/screens/applicant_signup_section.dart';
import 'package:jobbhai/features/authentication/screens/login_view.dart';
import 'package:jobbhai/features/authentication/screens/recruiter_signup_section.dart';

import '../widgets/registration_mini_info.dart';

class SignupView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupView(),
      );
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool applicantLoginSelected = true;

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio() {
    setState(() {
      applicantLoginSelected = !applicantLoginSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontSize: 27, fontWeight: FontWeight.w700);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Create an Account',
                  style: txtStyle,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text("Applicant"),
                        leading: Radio(
                          value: true,
                          groupValue: applicantLoginSelected,
                          onChanged: (bool? val) {
                            setSelectedRadio();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Recruiter"),
                        leading: Radio(
                          value: false,
                          groupValue: applicantLoginSelected,
                          onChanged: (bool? val) {
                            setSelectedRadio();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                applicantLoginSelected
                    ? const ApplicantSignupSection()
                    : const RecruiterSignupSection(),
                RegistrationMiniInfo(
                    route: LoginView.route(),
                    left: 'Already have an account?',
                    right: 'Login'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
