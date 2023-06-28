import 'package:flutter/material.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/applicant_details_section.dart';
import 'package:jobbhai/model/applicant.dart';

class ApplicantDetails extends StatelessWidget {
  final Applicant applicant;
  const ApplicantDetails({super.key, required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ApplicantDetailsSection(applicant: applicant),
        ),
      ),
    );
  }
}
