// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_forms_kit.dart';

class LightIconBox extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;

  final bool showTitle;
  const LightIconBox(
      {super.key,
      required this.icon,
      required this.title,
      this.showTitle = true,
      required this.subtitle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: height,
          // width: width,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: color.withOpacity(0.2), shape: BoxShape.circle
              // borderRadius: BorderRadius.circular(20),
              ),
          child: SvgPicture.asset(
            icon,
            color: color,
            height: 25,
            width: 25,
          ),
        ),
        const SizedBox(height: 7),
        CustomText(text: title, size: 12),
        const SizedBox(height: 8),
        CustomText(text: subtitle, bold: true, size: 16)
      ],
    );
  }
}
