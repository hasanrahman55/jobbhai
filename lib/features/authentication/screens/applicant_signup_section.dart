import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/custom_forms_kit.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class ApplicantSignupSection extends ConsumerStatefulWidget {
  const ApplicantSignupSection({super.key});

  @override
  ConsumerState<ApplicantSignupSection> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<ApplicantSignupSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // late File image;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Future<File?> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final imageFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (imageFile != null) {
  //     return File(imageFile.path);
  //   }
  //   return null;
  // }

  // Future<void> pickImage2() async {
  //   final image = await PickFile.pickImage();
  // }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).applicantSignUp(
        email: emailController.text,
        password: passwordController.text,
        context: context,
        name: ''
        // file: image,
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
            CustomAuthField(
              controller: emailController,
              hintText: 'Email',
            ),
            CustomAuthField(
              controller: passwordController,
              hintText: 'Password',
              isPasswordField: true,
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: onSignUp,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const CustomText(text: 'Sign up', color: Colors.white),
            ),
            // ElevatedButton(
            //     onPressed: pickImage2,
            //     child: const Text('pickImage')),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
