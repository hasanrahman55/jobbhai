import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jobbhai/constants/appwrite_constant.dart';
import 'package:jobbhai/core/failure.dart';
import 'package:jobbhai/core/type_def.dart';
import 'package:jobbhai/model/apply_job.dart';
import 'package:jobbhai/model/applicant.dart';
import 'package:jobbhai/model/recruiter.dart';
import 'package:jobbhai/model/job.dart';
import 'appwrite_injects.dart';

final databaseAPIProvider = Provider((ref) {
  return DatabaseAPI(
    databases: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class DataBaseInterface {
  FutureEither<Document> saveRecruiterDetails({
    required Recruiter recruiter,
    required String id,
  });
  FutureEither<Document> saveApplicantDetails({
    required Applicant applicant,
    required String id,
  });
  FutureEither<Document> updateApplicantProfileDetails({
    required Applicant applicant,
  });
  FutureEither<Document> postJob({required Job jobDetails});
  FutureEither<Document> applyJob({required ApplyJob applyJob});
  Future<Document> getApplicantProfile({required String id});
  Future<Document> getRecruiterProfile({required String id});
  FutureEither<Document> updateJob({
    required Job job,
    required Map<String, dynamic> jobUpdate,
  });
  FutureEither<Document> updateApplicantProfileWithJobId({
    required Applicant applicant,
  });
  FutureEither<Document> addJobIdToRecruiterProfile({
    required Recruiter recruiter,
  });
  Future<List<Document>> getPostedJobs();
  Future<List<Document>> getApplicants();
  Future<Document> myPostedJobs({required String jobId});
  Future<Document> getAppliedApplicants({required String applicationId});
  Future<Document> getAppliedJobs({required String appliedJobId});
  Future<List<Document>> searchJobs({required String keyword});
  FutureEither<Document> saveJob({
    required Applicant applicant,
  });

  FutureEither<Document> acceptOrRejectApplicant({
    required ApplyJob applyJob,
  });
}

class DatabaseAPI implements DataBaseInterface {
  final Databases _databases;

  DatabaseAPI({
    required Databases databases,
  }) : _databases = databases;
  @override
  FutureEither<Document> applyJob({required ApplyJob applyJob}) async {
    try {
      final post = await _databases.createDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.appliedJobCollectionId,
        documentId: ID.custom(applyJob.applicationId),
        data: applyJob.toMap(),
      );
      return right(post);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> postJob({required Job jobDetails}) async {
    try {
      final post = await _databases.createDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        documentId: ID.unique(),
        data: jobDetails.toMap(),
      );
      return right(post);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> saveApplicantDetails({
    required Applicant applicant,
    required String id,
  }) async {
    try {
      final saveRecruiter = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.applicantCollectionId,
        documentId: ID.custom(id),
        data: applicant.toMap(),
      );
      return right(saveRecruiter);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> saveRecruiterDetails({
    required Recruiter recruiter,
    required String id,
  }) async {
    try {
      final saveRecruiter = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.recruiterCollectionId,
        documentId: ID.custom(id),
        data: recruiter.toMap(),
      );
      return right(saveRecruiter);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Document> getApplicantProfile({
    required String id,
  }) async {
    final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.applicantCollectionId,
      documentId: id,
    );
    return details;
  }

  @override
  Future<Document> getRecruiterProfile({required String id}) async {
    final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.recruiterCollectionId,
      documentId: id,
    );
    return details;
  }

  @override
  Future<List<Document>> getPostedJobs() async {
    final jobs = await _databases.listDocuments(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        queries: [Query.orderDesc('time')]);
    return jobs.documents;
  }

  @override
  FutureEither<Document> updateApplicantProfileWithJobId({
    required Applicant applicant,
  }) async {
    try {
      final update = await _databases.updateDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.applicantCollectionId,
        documentId: applicant.id,
        data: {
          'appliedJobs': applicant.appliedJobs,
          'applications': applicant.applications,
        },
      );
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> updateJob({
    required Job job,
    required Map<String, dynamic> jobUpdate,
  }) async {
    try {
      final update = await _databases.updateDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        documentId: job.jobId,
        data: jobUpdate,
      );
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> addJobIdToRecruiterProfile({
    required Recruiter recruiter,
  }) async {
    try {
      final addJobId = await _databases.updateDocument(
          databaseId: AppWriteConstant.usersDatabaseId,
          collectionId: AppWriteConstant.recruiterCollectionId,
          documentId: recruiter.id,
          data: {'postedJobs': recruiter.postedJobs});
      return right(addJobId);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Document> myPostedJobs({required String jobId}) async {
    final myJob = await _databases.getDocument(
      databaseId: AppWriteConstant.jobDatabaseId,
      collectionId: AppWriteConstant.postedJobCollectionId,
      documentId: jobId,
    );
    return myJob;
  }

  @override
  Future<Document> getAppliedApplicants({required String applicationId}) async {
    final candidates = await _databases.getDocument(
      databaseId: AppWriteConstant.jobDatabaseId,
      collectionId: AppWriteConstant.appliedJobCollectionId,
      documentId: applicationId,
    );
    return candidates;
  }

  @override
  FutureEither<Document> saveJob({required Applicant applicant}) async {
    try {
      final update = await _databases.updateDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.applicantCollectionId,
        documentId: applicant.id,
        data: {'savedJobs': applicant.savedJobs},
      );
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<List<Document>> getApplicants() async {
    final jobs = await _databases.listDocuments(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.applicantCollectionId,
    );
    return jobs.documents;
  }

  @override
  FutureEither<Document> updateApplicantProfileDetails({
    required Applicant applicant,
  }) async {
    try {
      final update = await _databases.updateDocument(
          databaseId: AppWriteConstant.usersDatabaseId,
          collectionId: AppWriteConstant.applicantCollectionId,
          documentId: applicant.id,
          data: applicant.toMap());
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> acceptOrRejectApplicant({
    required ApplyJob applyJob,
  }) async {
    try {
      final post = await _databases.updateDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.appliedJobCollectionId,
        documentId: applyJob.applicationId,
        data: {
          'status': applyJob.status.text,
          'acceptanceMessage': applyJob.acceptanceMessage,
        },
      );
      return right(post);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Document> getAppliedJobs({required String appliedJobId}) async {
    final myJob = await _databases.getDocument(
      databaseId: AppWriteConstant.jobDatabaseId,
      collectionId: AppWriteConstant.appliedJobCollectionId,
      documentId: appliedJobId,
    );
    return myJob;
  }

  @override
  Future<List<Document>> searchJobs({required String keyword}) async {
    final jobs = await _databases.listDocuments(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        queries: [
          Query.search('jobTitle', keyword),
        ]);
    return jobs.documents;
  }
}
