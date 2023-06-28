// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/common/info_chip.dart';
import 'package:jobbhai/common/svg_icon_mini.dart';
import 'package:jobbhai/constants/app_svg.dart';
import 'package:jobbhai/core/resuables/date_format.dart';
import 'package:jobbhai/features/applicant/profile/widgets/profile_info_box.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/routes/app_route.dart';
import 'package:jobbhai/theme/colors.dart';

import 'widgets/infobox.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final applicant = ref.watch(applicantStateProvider)!;
    final applicantAccount = ref.watch(currentUserAccountProvider).value;

// final offers = ref.watch(appl)

    if (applicantAccount == null) {
      return const CircularProgressIndicator();
    }

    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, AppRoute.editApplicantProfile,
                  arguments: applicant),
              icon: const Icon(IconlyBold.edit))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(applicant.profilePicture),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(applicant.name,
                      style: textStyle!
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(applicant.title,
                      style: textStyle.copyWith(fontSize: 15)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoBox(
                  text: applicant.appliedJobs.length.toString(),
                  subtext: 'Applied'),
              InfoBox(
                  text:
                      formatDate(DateTime.parse(applicantAccount.registration)),
                  subtext: 'Member Since'),
              const InfoBox(text: '19', subtext: 'Offers'),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          ProfileInfoBox(
            title: 'Contact Information',
            icon: AppSvg.userBold,
            children:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  const SvgIconMini(svg: AppSvg.locationLight),
                  const SizedBox(width: 5),
                  CustomText(text: applicant.location, size: 14),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const SvgIconMini(svg: AppSvg.mailLight),
                  const SizedBox(width: 5),
                  CustomText(text: applicant.email, size: 14),
                ],
              ),
            ]),
          ),
          ProfileInfoBox(
            title: 'Summary',
            icon: AppSvg.documentTextBold,
            children: CustomText(text: applicant.about, size: 14),
          ),
          ProfileInfoBox(
            title: 'Skills',
            icon: AppSvg.awardBold,
            children: Wrap(
              spacing: 8.0,
              runSpacing: 10,
              children: applicant.skills
                  .map((item) => InfoChip(
                        title: item,
                        titleColor: AppColors.primaryColor,
                      ))
                  .toList(),
            ),
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
        ]),
      )),
    );
  }
}
