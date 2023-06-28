import 'dart:convert';

import 'package:jobbhai/core/extensions/job_status.dart';

import '../core/enums/application_status.dart';

class ApplyJob {
  final String applicantId;
  final String coverLetter;
  final String cvId;
  final String applicationId;
  final String companyId;
  final String jobId;
  final String acceptanceMessage;
  final DateTime appliedTime;
  final ApplicationStatus status;
  ApplyJob({
    required this.applicantId,
    required this.coverLetter,
    required this.cvId,
    required this.applicationId,
    required this.companyId,
    required this.jobId,
    required this.acceptanceMessage,
    required this.appliedTime,
    required this.status,
  });

  ApplyJob copyWith({
    String? applicantId,
    String? coverLetter,
    String? cvId,
    String? applicationId,
    String? companyId,
    String? jobId,
    String? acceptanceMessage,
    DateTime? appliedTime,
    ApplicationStatus? status,
  }) {
    return ApplyJob(
      applicantId: applicantId ?? this.applicantId,
      coverLetter: coverLetter ?? this.coverLetter,
      cvId: cvId ?? this.cvId,
      applicationId: applicationId ?? this.applicationId,
      companyId: companyId ?? this.companyId,
      jobId: jobId ?? this.jobId,
      acceptanceMessage: acceptanceMessage ?? this.acceptanceMessage,
      appliedTime: appliedTime ?? this.appliedTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicantId': applicantId,
      'coverLetter': coverLetter,
      'cvId': cvId,
      'companyId': companyId,
      'jobId': jobId,
      'acceptanceMessage': acceptanceMessage,
      'appliedTime': appliedTime.millisecondsSinceEpoch,
      'status': status.text,
    };
  }

  factory ApplyJob.fromMap(Map<String, dynamic> map) {
    return ApplyJob(
      applicantId: map['applicantId'] as String,
      coverLetter: map['coverLetter'] as String,
      cvId: map['cvId'] as String,
      applicationId: map['\$id'] as String,
      companyId: map['companyId'] as String,
      jobId: map['jobId'] as String,
      acceptanceMessage: map['acceptanceMessage'] as String,
      appliedTime:
          DateTime.fromMillisecondsSinceEpoch(map['appliedTime'] as int),
      status: (map['status'] as String).applicationStatus(),
    );
  }

  @override
  String toString() {
    return 'ApplyJob(applicantId: $applicantId, coverLetter: $coverLetter, cvId: $cvId, applicationId: $applicationId, companyId: $companyId, jobId: $jobId, acceptanceMessage: $acceptanceMessage, appliedTime: $appliedTime, status: $status)';
  }

  @override
  bool operator ==(covariant ApplyJob other) {
    if (identical(this, other)) return true;

    return other.applicantId == applicantId &&
        other.coverLetter == coverLetter &&
        other.cvId == cvId &&
        other.applicationId == applicationId &&
        other.companyId == companyId &&
        other.jobId == jobId &&
        other.acceptanceMessage == acceptanceMessage &&
        other.appliedTime == appliedTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return applicantId.hashCode ^
        coverLetter.hashCode ^
        cvId.hashCode ^
        applicationId.hashCode ^
        companyId.hashCode ^
        jobId.hashCode ^
        acceptanceMessage.hashCode ^
        appliedTime.hashCode ^
        status.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory ApplyJob.fromJson(String source) =>
      ApplyJob.fromMap(json.decode(source) as Map<String, dynamic>);
}
