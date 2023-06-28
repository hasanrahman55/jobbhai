import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/apis/cloud_storage_api.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/constants/app_svg.dart';
import 'package:jobbhai/core/enums/application_status.dart';
import 'package:jobbhai/core/extensions/to_msp.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/controller/post_job_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/applicant_details_section.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/decorated_box_container.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/see_more_text.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/widget/view_cv.dart';
import 'package:jobbhai/model/apply_job.dart';
import 'package:jobbhai/theme/colors.dart';

class AppliedApplicantDetails extends ConsumerStatefulWidget {
  final ApplyJob applyJob;
  const AppliedApplicantDetails({super.key, required this.applyJob});

  @override
  ConsumerState<AppliedApplicantDetails> createState() =>
      _AppliedApplicantDetailsState();
}

String acceptMessage =
    'Congratulations🎉! You have qualified for interview. We shall reach out to you via your email.';
String rejectMessage =
    'Better luck next time, your application was rejected. We encourage you to apply other jobs available';

class _AppliedApplicantDetailsState
    extends ConsumerState<AppliedApplicantDetails> {
  bool pdfLoading = false;
  viewCv() async {
    final nav = Navigator.of(context);
    setState(() {
      pdfLoading = true;
    });
    await ref
        .watch(storageAPIProvider)
        .viewCv(fileId: widget.applyJob.cvId)
        .then((value) {
      setState(() {
        pdfLoading = false;
      });
      nav.push(MaterialPageRoute(
          builder: (context) => ViewCv(
                applicantName: '',
                filePath: value,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.applyJob;
    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ref
            .watch(applicantProfileDetailsProvider(details.applicantId))
            .when(
                data: (applicant) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        ApplicantDetailsSection(applicant: applicant),
                        InkWell(
                          onTap: viewCv,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade800,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 1.4)
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.greyColor.withOpacity(0.05)),
                            child: Row(children: [
                              SvgPicture.asset(AppSvg.filePdfBold,
                                  height: 30,
                                  width: 30,
                                  color: AppColors.primaryColor),
                              const SizedBox(width: 10),
                              CustomText(
                                  text: pdfLoading ? 'loading' : 'View CV'),
                              const Spacer(),
                              const Icon(IconlyLight.arrow_right_2,
                                  color: AppColors.primaryColor)
                            ]),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DecoratedBoxContainer(
                          children: [
                            const CustomText(
                                text: 'Cover Letter', bold: true, size: 18),
                            const SizedBox(height: 5),
                            SeeMoreText(text: details.coverLetter)
                            // Text(details.coverLetter,
                            //     textAlign: TextAlign.start,
                            //     style: textStyle!.copyWith(
                            //       fontSize: 14,
                            //       letterSpacing: 0.2,
                            //       wordSpacing: 3,
                            //     )),
                          ],
                        ),

                        // const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )),
      ),
      bottomNavigationBar: widget.applyJob.status != ApplicationStatus.review
          ? Theme(
              data: Theme.of(context)
                  .copyWith(splashFactory: NoSplash.splashFactory),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        surfaceTintColor: AppColors.primaryColor.toMSP(),
                        backgroundColor: Colors.white.toMSP(),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                width: 2, color: AppColors.primaryColor)))),
                    onPressed: () {},
                    child: CustomText(
                        text: widget.applyJob.status.text,
                        color: AppColors.primaryColor)),
              ),
            )
          : Row(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: AppColors.primaryColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(20),
                    onPressed: () {
                      ref
                          .watch(postJobControllerProvider.notifier)
                          .acceptOrReject(
                              context: context,
                              applyJob: widget.applyJob.copyWith(
                                  status: ApplicationStatus.rejected,
                                  acceptanceMessage: rejectMessage));
                    },
                    child: const CustomText(
                        text: 'Reject', color: AppColors.primaryColor)),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(20),
                    onPressed: () => ref
                        .watch(postJobControllerProvider.notifier)
                        .acceptOrReject(
                            context: context,
                            applyJob: widget.applyJob.copyWith(
                                status: ApplicationStatus.accepted,
                                acceptanceMessage: acceptMessage)),
                    child:
                        const CustomText(text: 'Accept', color: Colors.white)),
              ))
            ]),
    );
  }
}
