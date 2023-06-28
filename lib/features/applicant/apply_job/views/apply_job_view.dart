// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/constants/app_svg.dart';
import 'package:jobbhai/features/applicant/apply_job/controller/apply_job_conntroller.dart';
import 'package:jobbhai/model/applicant.dart';
import 'package:jobbhai/model/job.dart';
import 'package:jobbhai/theme/colors.dart';

import '../../../../../core/resuables/pick_file.dart';

class ApplyJobView extends ConsumerStatefulWidget {
  final Job jobDetails;
  final Applicant applicant;
  const ApplyJobView({
    super.key,
    required this.jobDetails,
    required this.applicant,
  });

  @override
  ConsumerState<ApplyJobView> createState() => _ApplyJobViewState();
}

class _ApplyJobViewState extends ConsumerState<ApplyJobView> {
  final coverLetterController = TextEditingController();
  File? cv;
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    void applyJob() {
      if (cv == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload a CV before submitting.'),
          ),
        );
      } else {
        ref.watch(applyJobControllerProvider.notifier).applyJob(
              context: context,
              cv: cv!,
              coverLetter: coverLetterController.text,
              jobId: widget.jobDetails.jobId,
              ref: ref,
              applicant: widget.applicant,
              selectedJob: widget.jobDetails,
            );
      }
    }

    Future<void> pickCV() async {
      cv = await PickFile.pickPdf();
      setState(() {
        isUploaded = true;
      });
    }

    final applyJobState = ref.watch(applyJobControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  text: 'Cover Letter', bold: true, formSpacing: true),
              CustomTextField(
                  controller: coverLetterController, enableMaxlines: true),
              const CustomText(
                  text: 'Upload CV', bold: true, formSpacing: true),
              GestureDetector(
                onTap: pickCV,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  dashPattern: const [10, 10],
                  color: Colors.grey.shade400.withOpacity(0.8),
                  strokeWidth: 2,
                  child: Container(
                    // padding: const EdgeInsets.all(20),
                    // margin: const EdgeInsets.all(20),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isUploaded
                          ? Colors.green.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppSvg.documentUploadBold,
                            color: AppColors.primaryColor.withOpacity(0.9),
                            height: 30,
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                              text: isUploaded ? 'Uploaded' : 'Browse file')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () => applyJob(),
                  child: applyJobState == ApplyJobState.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const CustomText(text: 'Submit', color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
