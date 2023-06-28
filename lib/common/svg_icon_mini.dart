import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconMini extends StatelessWidget {
  final Color? color;
  final String svg;
  const SvgIconMini({
    Key? key,
    required this.svg,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      height: 15,
      width: 15,
      color: color,
    );
  }
}
