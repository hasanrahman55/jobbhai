import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/apis/cloud_storage_api.dart';
import 'package:jobbhai/apis/database_api.dart';
import 'package:jobbhai/core/enums/application_status.dart';
import 'package:jobbhai/features/applicant/apply_job/widgets/apply_job_dialog.dart';
import 'package:jobbhai/model/applicant.dart';
import 'package:jobbhai/model/apply_job.dart';
import 'package:jobbhai/model/job.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/route_transition.dart';
import '../../../authentication/controller/auth_controller.dart';

enum ApplyJobState {
  initialState,
  loading,
}

final applyJobControllerProvider =
    StateNotifierProvider<ApplyJobController, ApplyJobState>((ref) {
  return ApplyJobController(
      databaseAPI: ref.watch(databaseAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});
final applicantListProvider = FutureProvider((ref) async {
  final applicant =
      await ref.watch(applyJobControllerProvider.notifier).getApplicantsList();
  return applicant;
});

final appliedJobsFutureProvider =
    FutureProvider.family.autoDispose((ref, String id) async {
  return await ref
      .watch(applyJobControllerProvider.notifier)
      .getAppliedJob(appliedJobId: id);
});

class ApplyJobController extends StateNotifier<ApplyJobState> {
  final DatabaseAPI _databaseAPI;
  final StorageAPI _storageAPI;
  ApplyJobController({
    required DatabaseAPI databaseAPI,
    required StorageAPI storageAPI,
  })  : _databaseAPI = databaseAPI,
        _storageAPI = storageAPI,
        super(ApplyJobState.initialState);

  void applyJob({
    required BuildContext context,
    required File cv,
    required String coverLetter,
    required String jobId,
    required WidgetRef ref,
    required Applicant applicant,
    required Job selectedJob,
  }) async {
    state = ApplyJobState.loading;
    final nav = Navigator.of(context);
    String applicationId = const Uuid().v1();
    final applicant = ref.watch(applicantStateProvider);
    if (applicant == null) {
      return;
    }
    String fileId = await _storageAPI.uploadFile(file: cv, isCv: true);
    List<String> applyJobsList = applicant.appliedJobs;
    List<String> applicationsList = applicant.applications;
    applyJobsList.add(selectedJob.jobId);
    applicationsList.add(applicationId);
    final updatedApplicantDetails = applicant.copyWith(
        appliedJobs: applyJobsList, applications: applicationsList);
    List<String> applicationList = selectedJob.applicationReceived;
    applicationList.add(applicationId);
    final updatedJobDetails =
        selectedJob.copyWith(applicationReceived: applicationList);

    ApplyJob applicantInfo = ApplyJob(
      applicantId: applicant.id,
      coverLetter: coverLetter,
      cvId: fileId,
      companyId: selectedJob.companyId,
      applicationId: applicationId,
      appliedTime: DateTime.now(),
      status: ApplicationStatus.review,
      jobId: selectedJob.jobId,
      acceptanceMessage: '',
    );
    final apply = await _databaseAPI.applyJob(applyJob: applicantInfo);
    state = ApplyJobState.initialState;
    apply.fold((l) {
      print(l.errorMsg);
    }, (r) async {
      await _databaseAPI.updateApplicantProfileWithJobId(
          applicant: updatedApplicantDetails);
      final res = await _databaseAPI.updateJob(
          job: updatedJobDetails,
          jobUpdate: {
            'applicationReceived': updatedJobDetails.applicationReceived
          });
      res.fold(
        (l) => print(l.errorMsg),
        (r) => nav.pushAndRemoveUntil(
            pageRouteTransition(const ApplyJobDialog()), (route) => false),
      );
    });
  }

  Future<List<Applicant>> getApplicantsList() async {
    final applicantList = await _databaseAPI.getApplicants();
    return applicantList
        .map((document) => Applicant.fromMap(document.data))
        .toList();
  }

  Future<ApplyJob> getAppliedJob({required String appliedJobId}) async {
    final jobs = await _databaseAPI.getAppliedJobs(appliedJobId: appliedJobId);
    return ApplyJob.fromMap(jobs.data);
  }
}
