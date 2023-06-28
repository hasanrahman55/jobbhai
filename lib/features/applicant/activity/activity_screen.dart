import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/common/searchbox.dart';
import 'package:jobbhai/features/applicant/apply_job/views/applied_job_status.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicant = ref.watch(applicantStateProvider)!;
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SearchBox(showFilterButton: false, isHome: false),
              SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: applicant.applications.length,
              itemBuilder: (context, index) {
                final applicationId =
                    applicant.applications.reversed.toList()[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppliedJobStatus(
                      applicationId: applicationId,
                    ));
              }),
        ),
      ]),
    );
  }
}
