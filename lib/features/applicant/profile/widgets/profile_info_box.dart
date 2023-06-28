import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/custom_forms_kit.dart';
import '../../../../../constants/app_svg.dart';
import '../../../../../theme/colors.dart';

class ProfileInfoBox extends StatefulWidget {
  final String title;
  final String icon;
  final Widget children;
  const ProfileInfoBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.children,
  }) : super(key: key);

  @override
  _ProfileInfoBoxState createState() => _ProfileInfoBoxState();
}

class _ProfileInfoBoxState extends State<ProfileInfoBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                blurRadius: 1,
                blurStyle: BlurStyle.outer,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SvgPicture.asset(
                  widget.icon,
                  color: AppColors.primaryColor,
                  height: 26,
                  width: 26,
                ),
                const SizedBox(width: 8),
                CustomText(text: widget.title, bold: true, size: 17),
                const Spacer(),
                SvgPicture.asset(
                  _isExpanded ? AppSvg.arrowUpBroken : AppSvg.arrowDownBroken,
                  color: AppColors.primaryColor,
                )
              ]),
              _isExpanded
                  ? Divider(
                      color: Colors.grey.shade400,
                    )
                  : const SizedBox(),
              AnimatedContainer(
                curve: Curves.bounceIn,
                duration: const Duration(milliseconds: 500),
                height: _isExpanded ? null : 0,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    widget.children,
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
