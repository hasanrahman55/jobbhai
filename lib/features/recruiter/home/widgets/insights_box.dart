import 'package:flutter/material.dart';

import '../../../../../../../common/custom_forms_kit.dart';
import '../../../../../../../theme/colors.dart';

class InsightsBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  const InsightsBox({
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
        color: AppColors.primaryColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColors.secondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 1)
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //       color: iconColor.withOpacity(0.3), shape: BoxShape.circle),
            //   child: SvgPicture.asset(icon, color: AppColors.secondaryColor),
            // ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(text: title, bold: true, size: 12),
                const SizedBox(height: 2),
                CustomText(text: subtitle, size: 40),
              ],
            )
          ]),
    );
  }
}
