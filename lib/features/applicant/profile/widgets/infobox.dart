import 'package:flutter/material.dart';

import '../../../../../common/custom_forms_kit.dart';
import '../../../../../theme/colors.dart';

class InfoBox extends StatelessWidget {
  final String text;
  final String subtext;
  const InfoBox({
    Key? key,
    required this.text,
    required this.subtext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurStyle: BlurStyle.outer,
              blurRadius: 1)
        ],
        // border: Border.all(width: 3, color: Colors.grey[200]!),
      ),
      child: Column(children: [
        CustomText(
            text: text, size: 20, bold: true, color: AppColors.primaryColor),
        const SizedBox(height: 5),
        CustomText(text: subtext, size: 14),
      ]),
    );
  }
}
