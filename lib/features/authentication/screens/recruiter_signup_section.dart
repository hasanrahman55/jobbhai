import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/core/resuables/pick_file.dart';

import '../../../common/custom_forms_kit.dart';
import '../../../constants/app_svg.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class RecruiterSignupSection extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RecruiterSignupSection(),
      );
  const RecruiterSignupSection({super.key});

  @override
  ConsumerState<RecruiterSignupSection> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<RecruiterSignupSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final websiteLinkController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final facebookController = TextEditingController();

  late File image;
  bool picked = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    companyNameController.dispose();
    websiteLinkController.dispose();
    twitterController.dispose();
    linkedinController.dispose();
    facebookController.dispose();
  }

  Future<void> pickImage1() async {
    image = await PickFile.pickImage();
    setState(() {
      picked = true;
    });
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).recruiterSignUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
          companyName: companyNameController.text,
          websiteLink: websiteLinkController.text,
          twitter: twitterController.text,
          linkedIn: linkedinController.text,
          facebook: facebookController.text,
          about: 'about',
          file: image,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => pickImage1(),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: picked ? FileImage(image) : null,
                child: !picked
                    ? const Icon(
                        Icons.upload,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomAuthField(
              controller: emailController,
              hintText: 'Email',
            ),
            CustomAuthField(
              controller: passwordController,
              hintText: 'Password',
              isPasswordField: true,
            ),
            CustomTextField(
              controller: companyNameController,
              hintText: 'Company Name',
              prefixIconSvg: AppSvg.briefcaseBold,
              showHintText: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: websiteLinkController,
              hintText: 'Website',
              prefixIconSvg: AppSvg.linkCircleBold,
              showHintText: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: twitterController,
              hintText: 'Twitter',
              prefixIconSvg: AppSvg.twitterBold,
              showHintText: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: linkedinController,
              hintText: 'Linkedin',
              prefixIconSvg: AppSvg.linkedinBold,
              showHintText: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: facebookController,
              hintText: 'Facebook',
              prefixIconSvg: AppSvg.facebookBold,
              showHintText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSignUp,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const CustomText(text: 'Submit', color: Colors.white),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
