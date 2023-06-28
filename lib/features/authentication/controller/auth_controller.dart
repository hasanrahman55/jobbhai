import 'dart:io';

import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/apis/auth_api.dart';
import 'package:jobbhai/apis/cloud_storage_api.dart';
import 'package:jobbhai/apis/database_api.dart';
import 'package:jobbhai/core/resuables/file_url.dart';
import 'package:jobbhai/features/authentication/screens/login_view.dart';
import 'package:jobbhai/model/applicant.dart';
import 'package:jobbhai/model/recruiter.dart';

import '../../../common/route_transition.dart';
import '../../../core/resuables/ui/snackbar_alert.dart';
import '../../../routes/app_route.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider),
      databaseAPI: ref.watch(databaseAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});
final applicantStateProvider = StateProvider<Applicant?>((ref) {
  return null;
});

final recruiterStateProvider = StateProvider<Recruiter?>((ref) {
  return null;
});
// final currentUserProvider = FutureProvider((ref) async {
//   final user = ref.watch(authApiProvider);
//   return await user.getAccountInfo();
// });

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final currentRecruiterDetailsProvider = FutureProvider((ref) async {
  final userId = ref.watch(currentUserAccountProvider).value!;
  final userDetails = await ref
      .watch(authControllerProvider.notifier)
      .recruiterProfile(id: userId.$id);
  return userDetails;
});

final currentApplicantDetailsProvider = FutureProvider.autoDispose((ref) async {
  final userId = ref.watch(currentUserAccountProvider).value!;
  final userDetails = await ref
      .watch(authControllerProvider.notifier)
      .applicantProfile(id: userId.$id);
  return userDetails;
});

//// Applied  applicant profile
final applicantProfileDetailsProvider =
    FutureProvider.family.autoDispose((ref, String id) async {
  final userDetails =
      await ref.watch(authControllerProvider.notifier).applicantProfile(id: id);
  return userDetails;
});

final recruiterProfileDetailsProvider =
    FutureProvider.family((ref, String id) async {
  final userDetails =
      await ref.watch(authControllerProvider.notifier).recruiterProfile(id: id);
  return userDetails;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final DatabaseAPI _databaseAPI;
  final StorageAPI _storageAPI;
  AuthController({
    required AuthAPI authAPI,
    required DatabaseAPI databaseAPI,
    required StorageAPI storageAPI,
  })  : _authAPI = authAPI,
        _databaseAPI = databaseAPI,
        _storageAPI = storageAPI,
        super(false);

  void recruiterSignUp({
    required String companyName,
    required String websiteLink,
    required String email,
    required String twitter,
    required String linkedIn,
    required String facebook,
    required String about,
    required String password,
    required File file,
    required BuildContext context,
  }) async {
    state = true;
    var nav = Navigator.of(context);
    String uploadedFileId =
        await _storageAPI.uploadFile(file: file, isCv: false);
    String fileUrl = FileUrl.fileUrl(
      fileId: uploadedFileId,
    );
    Recruiter recruiter = Recruiter(
      companyName: companyName,
      websiteLink: websiteLink,
      email: email,
      twitter: twitter,
      linkedIn: linkedIn,
      facebook: facebook,
      about: about,
      logoUrl: fileUrl,
      id: '',
      postedJobs: [],
    );
    final res =
        await _authAPI.recruiterSignUp(email: email, password: password);
    state = false;
    res.fold((l) {
      snackBarAlert(context, l.errorMsg);
    }, (r) async {
      final databaseRes = await _databaseAPI.saveRecruiterDetails(
          recruiter: recruiter, id: r.$id);
      databaseRes.fold((l) {}, (r) {
        nav.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginView()),
          (Route<dynamic> route) => false,
        );
      });
    });
  }

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void applicantSignUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    Applicant applicant = Applicant(
      name: name,
      email: email,
      skills: [],
      experience: [],
      location: '',
      title: '',
      about: '',
      profilePicture: '',
      id: '',
      appliedJobs: [],
      savedJobs: [],
      applications: [],
    );
    var nav = Navigator.of(context);
    final res =
        await _authAPI.applicantSignUp(email: email, password: password);
    state = false;
    res.fold((l) {
      snackBarAlert(context, l.errorMsg);
    }, (r) async {
      final databaseRes = await _databaseAPI.saveApplicantDetails(
          applicant: applicant, id: r.$id);
      databaseRes.fold((l) {
        snackBarAlert(context, l.errorMsg);
      }, (r) {
        nav.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginView()),
          (Route<dynamic> route) => false,
        );
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final nav = Navigator.of(context);
    state = true;
    final loginRes = await _authAPI.signIn(email: email, password: password);
    state = false;
    loginRes.fold((l) {
      snackBarAlert(context, l.errorMsg);
    }, (r) async {
      model.User? accountInfo = await _authAPI.currentUserAccount();
      if (accountInfo!.name.contains('applicant')) {
        final applicant =
            await _databaseAPI.getApplicantProfile(id: accountInfo.$id);
        ref
            .watch(applicantStateProvider.notifier)
            .update((state) => Applicant.fromMap(applicant.data));
      } else {
        final recruiter =
            await _databaseAPI.getRecruiterProfile(id: accountInfo.$id);
        ref
            .watch(recruiterStateProvider.notifier)
            .update((state) => Recruiter.fromMap(recruiter.data));
      }
      return switch (accountInfo.name) {
        'applicant' => nav.pushNamedAndRemoveUntil(AppRoute.applicantsHomeView,
            (route) => false), //home page of Applicant),
        'recruiter' => nav.pushNamedAndRemoveUntil(
            AppRoute.recruiterPageNavigator,
            (route) => false), //home page of Recruiter
        _ => const Scaffold(
            body: Center(
              child: Text("Unexpected Error,"),
            ),
          ),
      };
    });
  }

  Future<Recruiter> recruiterProfile({required String id}) async {
    final details = await _databaseAPI.getRecruiterProfile(id: id);
    return Recruiter.fromMap(details.data);
  }

  Future<Applicant> applicantProfile({required String id}) async {
    final details = await _databaseAPI.getApplicantProfile(id: id);
    return Applicant.fromMap(details.data);
  }

  void updateApplicantProfile({
    required Applicant applicant,
    File? image,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = true;
    String imageId = image == null
        ? ''
        : await _storageAPI.uploadFile(file: image, isCv: false);
    String imageUrl = FileUrl.fileUrl(fileId: imageId);
    final updatedDetails = applicant.copyWith(profilePicture: imageUrl);
    final update = await _databaseAPI.updateApplicantProfileDetails(
      applicant: updatedDetails,
    );
    state = false;
    update.fold((l) {
      snackBarAlert(context, l.errorMsg);
    }, (r) async {
      final applicant = await _databaseAPI.getApplicantProfile(id: r.$id);
      ref
          .watch(applicantStateProvider.notifier)
          .update((state) => Applicant.fromMap(applicant.data));
      Navigator.of(context).pop();
    });
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => print(l.errorMsg), (r) {
      Navigator.of(context).pushAndRemoveUntil(
        pageRouteTransition(
          const LoginView(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }
}
