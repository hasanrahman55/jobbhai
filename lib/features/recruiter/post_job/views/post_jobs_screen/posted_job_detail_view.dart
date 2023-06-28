// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/constants/app_svg.dart';
import 'package:jobbhai/core/resuables/date_format.dart';
import 'package:jobbhai/features/recruiter/post_job/controller/post_job_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/widgets/close_open_application.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/widgets/photo_pile.dart';
import 'package:jobbhai/model/job.dart';
import 'package:jobbhai/routes/app_route.dart';
import 'package:jobbhai/theme/colors.dart';

class PostedJobDetailView extends ConsumerWidget {
  final Job job;
  const PostedJobDetailView({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontWeight: FontWeight.normal);

    //final seletectedJob = ref.watch(postedJobDetailsProvider(job.jobId)).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
              onPressed: () => closeOrOpenApplicationDialog(
                  context: context,
                  jobStatus: job.isOpened,
                  onTap: () => ref
                      .watch(postJobControllerProvider.notifier)
                      .openOrCloseApplication(
                        job: job,
                        status: job.isOpened == true ? false : true,
                        context: context,
                      )),
              icon: const Icon(IconlyBold.edit))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              job.jobTitle,
              style:
                  txtStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              job.jobType,
              style: txtStyle.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 30),
            const DividerWithSpaces(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(children: [
                Row(
                  children: [
                    const IconWithText(
                      icon: AppSvg.peopleLight,
                      text: 'Applicants',
                    ),
                    const Spacer(),
                    PhotoPileWidget(
                      job.jobId,
                      avatarSize: 30,
                      overlapDistance: 15,
                    )
                  ],
                ),
                const DividerWithSpaces(),
                // const Row(
                //   children: [
                //     IconWithText(
                //       icon: AppSvg.trendUpLight,
                //       text: 'Audience Reached',
                //     ),
                //     Spacer(),
                //     Text('100k')
                //   ],
                // ),
                // const DividerWithSpaces(),
                Row(
                  children: [
                    const IconWithText(
                      icon: AppSvg.calenderEditLight,
                      text: 'Posted',
                    ),
                    const Spacer(),
                    Text(formatDate(job.time))
                  ],
                ),
                const DividerWithSpaces(),
                Row(
                  children: [
                    const IconWithText(
                      icon: AppSvg.calenderTickLight,
                      text: 'Deadline',
                    ),
                    const Spacer(),
                    Text(formatDate(job.deadline))
                  ],
                ),
              ]),
            ),
            const DividerWithSpaces(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
                  AppRoute.viewApplicants,
                  arguments: job.applicationReceived,
                ),
            child: Text(
              'View All Applicants',
              style: txtStyle.copyWith(color: AppColors.greyColor),
            )),
      ),
    );
  }
}

class DividerWithSpaces extends StatelessWidget {
  const DividerWithSpaces({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.grey),
    );
  }
}

class IconWithText extends StatelessWidget {
  final String icon;
  final String text;
  const IconWithText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.primaryColor,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
