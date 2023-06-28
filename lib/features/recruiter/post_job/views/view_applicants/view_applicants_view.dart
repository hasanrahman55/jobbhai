import 'package:flutter/material.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/applicant_card.dart';

class ViewApplicantsView extends StatelessWidget {
  final List<String> applicantId;
  const ViewApplicantsView({super.key, required this.applicantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('View Applicants')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: applicantId.isEmpty
              ? const Center(
                  child: CustomText(
                    text: 'No Applications received ',
                    size: 25,
                  ),
                )
              : ListView.builder(
                  itemCount: applicantId.length,
                  itemBuilder: (context, index) {
                    return ApplicantCard(applicationId: applicantId[index]);
                  }),
        ));
  }
}
