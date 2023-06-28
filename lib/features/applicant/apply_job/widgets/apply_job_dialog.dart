import 'package:flutter/material.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/routes/app_route.dart';
import 'package:lottie/lottie.dart';

class ApplyJobDialog extends StatelessWidget {
  const ApplyJobDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/done-success.zip',
                  repeat: false, height: 300, width: 300),
              const CustomText(
                  text: 'Job Application Sent', bold: true, size: 25),
              const SizedBox(height: 3),
              const CustomText(text: 'Successfully', bold: true, size: 25),
              const SizedBox(height: 10),
              const CustomText(text: 'Best of luck!'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoute.applicantsHomeView, (route) => false),
                  child: const CustomText(
                      text: 'Back to home', color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
