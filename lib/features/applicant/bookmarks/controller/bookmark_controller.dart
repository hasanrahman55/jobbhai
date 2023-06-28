import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/apis/database_api.dart';
import 'package:jobbhai/model/applicant.dart';

final bookmarkControllerProvider =
    StateNotifierProvider<BookMarkController, bool>((ref) {
  return BookMarkController(databaseAPI: ref.watch(databaseAPIProvider));
});

class BookMarkController extends StateNotifier<bool> {
  final DatabaseAPI _databaseAPI;
  BookMarkController({
    required DatabaseAPI databaseAPI,
  })  : _databaseAPI = databaseAPI,
        super(false);

  void bookmarkJob(
      {required Applicant applicant, required String jobId}) async {
    List<String> savedJobsList = applicant.savedJobs;
    if (!savedJobsList.contains(jobId)) {
      savedJobsList.add(jobId);
    } else {
      savedJobsList.remove(jobId);
    }
    final updatedApplicantDetails =
        applicant.copyWith(savedJobs: savedJobsList);
    final job = await _databaseAPI.saveJob(applicant: updatedApplicantDetails);
    job.fold((l) => print(l.errorMsg), (r) => null);
  }
}
