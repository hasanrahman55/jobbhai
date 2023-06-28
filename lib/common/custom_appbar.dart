// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? prefixIcon;
  final bool showSuffixIcon;
  final bool editProfile;
  final void Function()? onPrefixTap;
  final void Function()? onProfileEdit;

  IconData? suffixIcon;
  CustomAppBar({
    Key? key,
    // required this.selectedJob,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixTap,
    this.editProfile = false,
    this.showSuffixIcon = true,
    this.onProfileEdit,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        leading: GestureDetector(
          onTap: onPrefixTap,
          child: AppBarIcon(icon: prefixIcon ?? IconlyLight.arrow_left_2),
        ),
        title: Text(
          title,
          style: textStyle!.copyWith(fontWeight: FontWeight.w800, fontSize: 23),
        ),
        actions: editProfile
            ? [
                IconButton(
                  onPressed: onProfileEdit,
                  icon: const Icon(IconlyLight.edit_square),
                )
              ]
            : [],
        centerTitle: true,
      ),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  final IconData icon;
  const AppBarIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}
