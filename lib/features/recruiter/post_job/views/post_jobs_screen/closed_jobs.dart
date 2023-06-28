import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/widgets/job_card.dart';

class ClosedJobsView extends ConsumerWidget {
  const ClosedJobsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final closedJobs = ref.watch(recruiterStateProvider)!;

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: closedJobs.postedJobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (BuildContext context, int index) {
              final job = closedJobs.postedJobs.reversed.toList()[index];
              return JobCard(
                isActive: false,
                isApplicant: false,
                postedJobsId: job,
              );
            },
          )),
    );
  }
}
