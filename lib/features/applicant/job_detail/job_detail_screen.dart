// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/core/extensions/to_msp.dart';
import 'package:jobbhai/core/resuables/ui/snackbar_alert.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/decorated_box_container.dart';
import 'package:jobbhai/model/job.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:jobbhai/common/route_transition.dart';
import 'package:jobbhai/theme/colors.dart';

import '../../../../common/custom_forms_kit.dart';
import '../../../../common/info_chip.dart';
import '../../../../common/light_icon_box.dart';
import '../../../../constants/app_svg.dart';
import '../../../../core/resuables/date_format.dart';
import '../apply_job/views/apply_job_view.dart';

class JobDetailScreen extends ConsumerWidget {
  final Job jobsData;
  const JobDetailScreen({
    Key? key,
    required this.jobsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.displayLarge!;

    final applicant = ref.watch(applicantStateProvider)!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          // suffixIcon:
          //     selectedJob.isSaved ? IconlyBold.bookmark : IconlyLight.bookmark,
        ),
        body: SingleChildScrollView(
            child: ref
                .watch(recruiterProfileDetailsProvider(jobsData.companyId))
                .when(
                  data: (recruiter) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DecoratedBoxContainer(centered: true, children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurStyle: BlurStyle.outer,
                                                blurRadius: 1.5)
                                          ]),
                                      child: ClipOval(
                                        child: Image.network(
                                          recruiter.logoUrl,
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomText(
                                      text: jobsData.jobTitle,
                                      bold: true,
                                      size: 20,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomText(
                                      text: recruiter.companyName,
                                      color: AppColors.primaryColor,
                                      size: 15,
                                    ),
                                    const SizedBox(height: 15),
                                    InfoChip(
                                        title: jobsData.location,
                                        titleColor: AppColors.secondaryColor),
                                    const SizedBox(height: 15),
                                    CustomText(
                                      text:
                                          'Posted ${timeago.format(jobsData.time)}, ends in ${formatDate(jobsData.deadline)}',
                                      size: 13,
                                    ),
                                    const SizedBox(height: 5),
                                  ]),
                            ]),
                            DecoratedBoxContainer(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  LightIconBox(
                                      icon: AppSvg.dollarBold,
                                      title: 'Salary',
                                      color: Colors.orange,
                                      subtitle: jobsData.salary),
                                  LightIconBox(
                                      icon: AppSvg.briefcaseBold,
                                      title: 'Type',
                                      color: Colors.green,
                                      subtitle: jobsData.jobType),
                                  LightIconBox(
                                      icon: AppSvg.flashBold,
                                      title: 'Mode',
                                      color: Colors.blue,
                                      subtitle: jobsData.workingMode),
                                ],
                              )
                            ]),
                            const SizedBox(height: 10),
                            DecoratedBoxContainer(children: [
                              const CustomText(
                                  text: 'Description', bold: true, size: 18),
                              const SizedBox(height: 10),
                              CustomText(text: jobsData.description),
                            ]),
                            DecoratedBoxContainer(children: [
                              const CustomText(
                                  text: 'Requirements', bold: true, size: 18),
                              const SizedBox(height: 10),
                              BulletedListBuilder(
                                  list: jobsData.requirement, padding: true),
                            ]),
                            DecoratedBoxContainer(children: [
                              const CustomText(
                                  text: 'Responsibilities',
                                  bold: true,
                                  size: 18),
                              const SizedBox(height: 10),
                              BulletedListBuilder(
                                  list: jobsData.responsibilities,
                                  padding: true),
                            ]),
                            DecoratedBoxContainer(children: [
                              const CustomText(
                                  text: 'Perks & Benefits',
                                  bold: true,
                                  size: 18),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 10,
                                children: jobsData.benefits
                                    .map((item) => InfoChip(
                                          title: item,
                                          titleColor: AppColors.primaryColor,
                                          plain: true,
                                        ))
                                    .toList(),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(14),
          child: applicant.appliedJobs.contains(jobsData.jobId)
              ? Theme(
                  data: Theme.of(context)
                      .copyWith(splashFactory: NoSplash.splashFactory),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          surfaceTintColor: AppColors.primaryColor.toMSP(),
                          backgroundColor: Colors.white.toMSP(),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor)))),
                      onPressed: () {},
                      child: const CustomText(
                          text: 'Applied', color: AppColors.primaryColor)),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (jobsData.isOpened) {
                      Navigator.of(context).push(pageRouteTransition(
                          ApplyJobView(
                            jobDetails: jobsData,
                            applicant: applicant,
                          ),
                          td: TransitionDirection.bottom));
                    } else {
                      snackBarAlert(context, 'Application Closed');
                    }
                  },
                  child: Text(
                    'Apply Now',
                    style:
                        textStyle.copyWith(color: Colors.white, fontSize: 17),
                  )),
        ));
  }
}

/*
ElevatedButton(
            onPressed: () => Navigator.of(context).push(pageRouteTransition(
                ApplyJobView(
                    companyId: jobsData!.companyId, jobId: jobsData.jobId),
                td: TransitionDirection.bottom)),
            child: Text(
              'Apply Now',
              style: textStyle.copyWith(color: Colors.white, fontSize: 17),
            )),
*/
class BulletedListBuilder extends StatelessWidget {
  final List<String> list;
  final bool padding;
  const BulletedListBuilder({
    Key? key,
    required this.list,
    this.padding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: list
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: padding ? 8 : 0),
                child: ListTile(
                    dense: true,
                    minVerticalPadding: 0,
                    leading: const CustomText(
                        text: '•', color: AppColors.primaryColor, size: 25),
                    title: CustomText(text: item, size: 15)),
              ))
          .toList(),
    );
  }
}
