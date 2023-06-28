import 'package:flutter/material.dart';
import 'package:jobbhai/theme/colors.dart';

class VerticalBar extends StatelessWidget {
  final String title;
  final String trailing;
  final void Function()? onTap;

  Widget child;
  VerticalBar({
    Key? key,
    required this.title,
    this.trailing = 'See all',
    this.child = const SizedBox(),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.ideographic,
        children: [
          Row(
            children: [
              Text(title,
                  style: textStyle!
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 6,
              ),
              child,
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              trailing,
              style: textStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
