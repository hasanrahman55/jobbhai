import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/apis/database_api.dart';
import 'package:jobbhai/features/applicant/apply_job/controller/apply_job_conntroller.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/model/apply_job.dart';
import 'package:jobbhai/model/job.dart';
import 'package:jobbhai/routes/app_route.dart';

import '../../../../../core/resuables/ui/snackbar_alert.dart';

enum JobState {
  initialState,
  loading,
}

final postJobControllerProvider =
    StateNotifierProvider<PostJobController, JobState>((ref) {
  return PostJobController(databaseAPI: ref.watch(databaseAPIProvider));
});

final postedJobProvider = FutureProvider.autoDispose((ref) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.getJobs();
});
final myPostedJobProvider =
    FutureProvider.family.autoDispose((ref, String jobId) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.myJobs(jobId: jobId);
});

final appliedApplicantProvider =
    FutureProvider.family.autoDispose((ref, String applicationId) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.appliedApplicant(applicationId: applicationId);
});

final postedJobDetailsProvider =
    FutureProvider.family((ref, String postedJobId) async {
  final jobs = await ref.watch(postJobControllerProvider.notifier).getJobs();
  final res = jobs.where((job) => postedJobId == job.jobId).toList();
  return res.first;
});

final applicantsImageProvider =
    FutureProvider.family((ref, String jobId) async {
  final job =
      await ref.watch(postJobControllerProvider.notifier).myJobs(jobId: jobId);
  final applicants =
      await ref.watch(applyJobControllerProvider.notifier).getApplicantsList();
  final applicableApplicants = applicants
      .where((applicant) => applicant.appliedJobs.contains(job.jobId))
      .toList();

  final profilePictures = applicableApplicants
      .map((applicant) => applicant.profilePicture)
      .toList();
  return profilePictures;
});

class PostJobController extends StateNotifier<JobState> {
  final DatabaseAPI _databaseAPI;
  PostJobController({required DatabaseAPI databaseAPI})
      : _databaseAPI = databaseAPI,
        super(JobState.initialState);

  void postJob({
    required String jobTitle,
    required String workingMode,
    required String description,
    required String location,
    required String jobType,
    required String salary,
    required List<String> responsibilities,
    required List<String> requirement,
    required List<String> benefits,
    required WidgetRef ref,
    required DateTime deadline,
    required BuildContext context,
  }) async {
    state = JobState.loading;
    final recruiter = ref.watch(recruiterStateProvider);
    final nav = Navigator.of(context);
    if (recruiter != null) {
      List<String> postedJobIds = recruiter.postedJobs;
      Job jobDetails = Job(
        jobTitle: jobTitle,
        workingMode: workingMode,
        description: description,
        location: location,
        jobType: jobType,
        time: DateTime.now(),
        jobId: '',
        isOpened: true,
        companyId: recruiter.id,
        applicationReceived: [],
        salary: salary,
        responsibilities: responsibilities,
        requirement: requirement,
        benefits: benefits,
        deadline: deadline,
      );
      final job = await _databaseAPI.postJob(jobDetails: jobDetails);
      state = JobState.initialState;
      job.fold((l) {
        snackBarAlert(context, l.errorMsg);
      }, (r) async {
        postedJobIds.add(r.$id);
        final recruiterUpdatedDetails =
            recruiter.copyWith(postedJobs: postedJobIds);
        await _databaseAPI.addJobIdToRecruiterProfile(
            recruiter: recruiterUpdatedDetails);

        nav.pushNamedAndRemoveUntil(
            AppRoute.recruiterPageNavigator, (route) => false);
      });
    } else {
      state = JobState.initialState;
      snackBarAlert(context, 'Error Occurred');
    }
  }

  Future<List<Job>> getJobs() async {
    final jobs = await _databaseAPI.getPostedJobs();
    return jobs.map((job) => Job.fromMap(job.data)).toList();
  }

  Future<Job> myJobs({required String jobId}) async {
    final job = await _databaseAPI.myPostedJobs(jobId: jobId);
    final postJob = Job.fromMap(job.data);
    return postJob;
  }

  Future<ApplyJob> appliedApplicant({required String applicationId}) async {
    final job =
        await _databaseAPI.getAppliedApplicants(applicationId: applicationId);
    final postJob = ApplyJob.fromMap(job.data);
    return postJob;
  }

  void acceptOrReject({
    required ApplyJob applyJob,
    required BuildContext context,
  }) async {
    state = JobState.loading;
    final status =
        await _databaseAPI.acceptOrRejectApplicant(applyJob: applyJob);
    state = JobState.initialState;
    status.fold((l) => snackBarAlert(context, l.errorMsg), (r) {
      Navigator.pop(context);
    });
  }

  void openOrCloseApplication({
    required Job job,
    required bool status,
    required BuildContext context,
  }) async {
    final jobUpdate = await _databaseAPI.updateJob(job: job, jobUpdate: {
      'isOpened': status,
    });
    jobUpdate.fold(
        (l) => snackBarAlert(context, l.errorMsg),
        (r) => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.recruiterPageNavigator,
              (route) => false,
            ));
  }
}
