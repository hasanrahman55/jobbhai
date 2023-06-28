import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double fontSize;
  final BorderRadius? borderRadius;
  final IconData? leading;
  final bool plain;
  final bool bold;
  const InfoChip(
      {Key? key,
      required this.title,
      required this.titleColor,
      this.borderRadius,
      this.bold = true,
      this.fontSize = 15,
      this.plain = false,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: plain ? Colors.white : titleColor.withOpacity(0.15),
            border: plain ? Border.all(color: titleColor) : null,
            borderRadius: borderRadius ?? BorderRadius.circular(6)),
        child: Text(
          " $title ",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: titleColor,
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.w500 : FontWeight.normal),
        ));
  }
}
