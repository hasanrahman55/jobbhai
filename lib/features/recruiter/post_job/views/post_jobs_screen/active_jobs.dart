import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/widgets/job_card.dart';

class ActiveJobsView extends ConsumerWidget {
  const ActiveJobsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeJobs = ref.watch(recruiterStateProvider)!;

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeJobs.postedJobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (BuildContext context, int index) {
              final job = activeJobs.postedJobs.reversed.toList()[index];
              return JobCard(
                isActive: true,
                isApplicant: false,
                postedJobsId: job,
              );
            },
          )),
    );
  }
}
