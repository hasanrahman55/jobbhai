// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/features/applicant/job_detail/job_detail_screen.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/model/job.dart';

import '../../../../../common/route_transition.dart';
import '../../../../../common/svg_icon_mini.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../../../../../constants/app_svg.dart';
import '../../bookmarks/controller/bookmark_controller.dart';

class RecentJobCard extends ConsumerStatefulWidget {
  final Job job;
  final Color imageBackground;

  const RecentJobCard({
    Key? key,
    required this.imageBackground,
    required this.job,
  }) : super(key: key);

  @override
  ConsumerState<RecentJobCard> createState() => _RecentJobCardState();
}

class _RecentJobCardState extends ConsumerState<RecentJobCard> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    return InkWell(
        onTap: () =>
            Navigator.of(context).push(pageRouteTransition(JobDetailScreen(
              jobsData: widget.job,
            ))),
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 1)
            ],
          ),
          child: Row(
            children: [
              ref
                  .watch(recruiterProfileDetailsProvider(widget.job.companyId))
                  .when(
                      data: (recruiter) {
                        return ClipOval(
                          child: Image.network(
                            recruiter.logoUrl,
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                          ),
                        );
                      },
                      error: (e, t) => const SizedBox(),
                      loading: () => const SizedBox()),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.job.jobTitle,
                            style: textStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SvgIconMini(svg: AppSvg.locationLight),
                        Text(
                          ' ${widget.job.location}',
                          style: textStyle.copyWith(fontSize: 11),
                        ),
                        const SizedBox(width: 10),
                        const SvgIconMini(svg: AppSvg.briefcaseLight),
                        Text(
                          ' ${widget.job.jobType}',
                          style: textStyle.copyWith(fontSize: 11),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  // ref.watch(currentApplicantDetailsProvider).when(
                  //     data: (applicant) {
                  //       return
                  InkWell(
                    onTap: () {
                      ref
                          .watch(bookmarkControllerProvider.notifier)
                          .bookmarkJob(
                              applicant: ref.watch(applicantStateProvider)!,
                              jobId: widget.job.jobId);
                      setState(() {});
                    },
                    child: Icon(
                      ref
                              .watch(applicantStateProvider)!
                              .savedJobs
                              .contains(widget.job.jobId)
                          ? IconlyBold.bookmark
                          : IconlyLight.bookmark,
                      color: Colors.grey[700],
                    ),
                  ),
                  // },
                  // error: (error, stack) => const SizedBox(),
                  // loading: () => const SizedBox()),
                  const SizedBox(height: 10),
                  Text(timeAgo.format(widget.job.time, locale: 'en_short'))
                ],
              )
            ],
          ),
        ));
  }
}
