import 'package:flutter/material.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';

class ApplicationStatusMessage extends StatelessWidget {
  final String text;
  const ApplicationStatusMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomText(text: text),
        ),
      ),
    );
  }
}
