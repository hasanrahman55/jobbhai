import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/features/applicant/profile/widgets/profile_info_box.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/common/svg_icon_mini.dart';
import 'package:jobbhai/constants/app_svg.dart';
import 'package:jobbhai/theme/colors.dart';

class RecruiterProfileScreen extends ConsumerWidget {
  const RecruiterProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recruiter = ref.watch(recruiterStateProvider)!;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(recruiter!.logoUrl),
            ),
            const SizedBox(height: 15),
            CustomText(text: recruiter.companyName, bold: true),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            ProfileInfoBox(
              title: 'Contact Information',
              icon: AppSvg.userBold,
              children: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SvgIconMini(
                            svg: AppSvg.mailLight,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        CustomText(text: recruiter.email, size: 14),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SvgIconMini(
                            svg: AppSvg.linkCircleLight,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        CustomText(text: recruiter.websiteLink, size: 14),
                      ],
                    ),
                  ]),
            ),
            ProfileInfoBox(
              title: 'About',
              icon: AppSvg.documentTextBold,
              children: CustomText(text: recruiter.about, size: 14),
            ),
            ProfileInfoBox(
              title: 'Socials',
              icon: AppSvg.mainComponentBold,
              children: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SvgIconMini(
                            svg: AppSvg.linkedinBold,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        CustomText(text: recruiter.linkedIn, size: 14),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SvgIconMini(
                            svg: AppSvg.facebookBold,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        CustomText(text: recruiter.facebook, size: 14),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SvgIconMini(
                            svg: AppSvg.twitterBold,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 5),
                        CustomText(text: recruiter.twitter, size: 14),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            ProfileInfoBox(
              title: 'Settings',
              icon: AppSvg.settingBold,
              children: ListTile(
                dense: true,
                leading: const Icon(IconlyLight.logout, size: 20),
                title: const Text('Logout'),
                onTap: () =>
                    ref.watch(authControllerProvider.notifier).logout(context),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        )));
  }
}
