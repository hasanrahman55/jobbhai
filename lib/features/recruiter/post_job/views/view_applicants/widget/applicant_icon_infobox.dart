import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../common/custom_forms_kit.dart';
import '../../../../../../../theme/colors.dart';

class ApplicantIconInfoBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  const ApplicantIconInfoBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColors.secondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 1)
        ],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: iconColor.withOpacity(0.3), shape: BoxShape.circle),
          child: SvgPicture.asset(icon, color: AppColors.secondaryColor),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title, size: 12),
            const SizedBox(height: 2),
            CustomText(text: subtitle, bold: true)
          ],
        )
      ]),
    );
  }
}
