import 'package:flutter/material.dart';
import 'package:jobbhai/common/route_transition.dart';
import 'package:jobbhai/features/applicant/apply_job/views/application_status_message.dart';
import 'package:jobbhai/features/applicant/home/views/page_navigator.dart';
import 'package:jobbhai/features/applicant/job_search/screen/search_creen.dart';
import 'package:jobbhai/features/applicant/profile/edit_profile.dart';

import 'package:jobbhai/features/recruiter/home/views/page_navigator.dart';
import 'package:jobbhai/features/recruiter/home/views/recruiter_home.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/post_a_job_view.dart';
import 'package:jobbhai/features/recruiter/post_job/views/post_jobs_screen/posted_job_detail_view.dart';
import 'package:jobbhai/features/recruiter/post_job/views/view_applicants/view_applicants_view.dart';

class AppRoute {
  static const String postedJobDetailsView = 'posted-job-detail-view';
  static const String postAJobView = 'post-a-job-view';
  static const String viewApplicants = 'view-applicants-view';
  static const String applicantsHomeView = 'applicants-home-view';
  static const String recruiterHomeView = 'recruiter-home-view';
  static const String recruiterPageNavigator = 'recruiter-page-navigator';
  static const String editApplicantProfile = 'edit-applicant-profile';
  static const String jobSearch = 'job-search';
  static const String applicationStatusMessage = 'application-status-message';

  static Route<dynamic> toPage(Widget page,
          {bool fade = false,
          TransitionDirection td = TransitionDirection.right}) =>
      pageRouteTransition(page, fade: fade, td: td);

  static Route<dynamic> generatedRoute(RouteSettings routeSettings) {
    dynamic routeObject;
    if (routeSettings.arguments != null) {
      routeObject = routeSettings.arguments;
    }

    return switch (routeSettings.name) {
      postedJobDetailsView => toPage(PostedJobDetailView(job: routeObject)),
      postAJobView => toPage(const PostAJobView()),
      viewApplicants => toPage(ViewApplicantsView(applicantId: routeObject)),
      applicantsHomeView => toPage(const ApplicantPageNavigator()),
      recruiterHomeView => toPage(const RecruiterHomeView()),
      recruiterPageNavigator => toPage(const RecruiterPageNavigator()),
      jobSearch => toPage(const JobSearch()),
      applicationStatusMessage => toPage(ApplicationStatusMessage(
          text: routeObject,
        )),
      editApplicantProfile => toPage(EditApplicantProfile(
          applicant: routeObject,
        )),
      _ => MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Wrong route'),
                ),
              )),
    };
  }
}
