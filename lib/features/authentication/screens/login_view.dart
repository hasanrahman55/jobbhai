import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/features/authentication/screens/signup_view.dart';
import 'package:jobbhai/features/authentication/widgets/registration_mini_info.dart';

import '../../../common/custom_forms_kit.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context,
        ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

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
                const SizedBox(height: 80),
                Text(
                  'Login to your account',
                  style: txtStyle,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomAuthField(
                          controller: emailController,
                          hintText: 'Email',
                          isPasswordField: false,
                        ),
                        CustomAuthField(
                          controller: passwordController,
                          hintText: 'Password',
                          isPasswordField: true,
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: onLogin,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const CustomText(
                                    text: 'Log in', color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                RegistrationMiniInfo(
                    route: SignupView.route(),
                    left: 'Don\'t have an account?',
                    right: 'Sign up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
