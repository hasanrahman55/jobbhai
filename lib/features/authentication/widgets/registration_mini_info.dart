import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class RegistrationMiniInfo extends StatelessWidget {
  final Route route;
  final String left;
  final String right;

  const RegistrationMiniInfo({
    super.key,
    required this.route,
    required this.left,
    required this.right,
  });
  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontSize: 14, fontWeight: FontWeight.normal);
    return RichText(
      text: TextSpan(
        text: left,
        style: txtStyle,
        children: [
          TextSpan(
            text: ' $right',
            style: txtStyle.copyWith(color: AppColors.primaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  route,
                );
              },
          ),
        ],
      ),
    );
  }
}
