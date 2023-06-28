import 'dart:convert';

import 'package:collection/collection.dart';

class Job {
  final String jobTitle;
  final String workingMode;
  final String description;
  final String location;
  final String jobType;
  final DateTime time;
  final String jobId;
  final bool isOpened;
  final String companyId;
  final List<String> applicationReceived;
  final String salary;
  final List<String> responsibilities;
  final List<String> requirement;
  final List<String> benefits;
  final DateTime deadline;
  Job({
    required this.jobTitle,
    required this.workingMode,
    required this.description,
    required this.location,
    required this.jobType,
    required this.time,
    required this.jobId,
    required this.isOpened,
    required this.companyId,
    required this.applicationReceived,
    required this.salary,
    required this.responsibilities,
    required this.requirement,
    required this.benefits,
    required this.deadline,
  });

  Job copyWith({
    String? jobTitle,
    String? workingMode,
    String? description,
    String? location,
    String? jobType,
    DateTime? time,
    String? jobId,
    bool? isOpened,
    String? companyId,
    List<String>? applicationReceived,
    String? salary,
    List<String>? responsibilities,
    List<String>? requirement,
    List<String>? benefits,
    DateTime? deadline,
  }) {
    return Job(
      jobTitle: jobTitle ?? this.jobTitle,
      workingMode: workingMode ?? this.workingMode,
      description: description ?? this.description,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      time: time ?? this.time,
      jobId: jobId ?? this.jobId,
      isOpened: isOpened ?? this.isOpened,
      companyId: companyId ?? this.companyId,
      applicationReceived: applicationReceived ?? this.applicationReceived,
      salary: salary ?? this.salary,
      responsibilities: responsibilities ?? this.responsibilities,
      requirement: requirement ?? this.requirement,
      benefits: benefits ?? this.benefits,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'workingMode': workingMode,
      'description': description,
      'location': location,
      'jobType': jobType,
      'time': time.millisecondsSinceEpoch,
      'isOpened': isOpened,
      'companyId': companyId,
      'applicationReceived': applicationReceived,
      'salary': salary,
      'responsibilities': responsibilities,
      'requirement': requirement,
      'benefits': benefits,
      'deadline': deadline.millisecondsSinceEpoch,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobTitle: map['jobTitle'] as String,
      workingMode: map['workingMode'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      jobType: map['jobType'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      jobId: map['\$id'] as String,
      isOpened: map['isOpened'] as bool,
      companyId: map['companyId'] as String,
      applicationReceived: List<String>.from(map['applicationReceived'] ?? []),
      salary: map['salary'] as String,
      responsibilities: List<String>.from(map['responsibilities'] ?? []),
      requirement: List<String>.from(map['requirement'] ?? []),
      benefits: List<String>.from(map['benefits'] ?? []),
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
    );
  }

  @override
  String toString() {
    return 'Job(jobTitle: $jobTitle, workingMode: $workingMode, description: $description, location: $location, jobType: $jobType, time: $time, jobId: $jobId, isOpened: $isOpened, companyId: $companyId, applicationReceived: $applicationReceived, salary: $salary, responsibilities: $responsibilities, requirement: $requirement, benefits: $benefits, deadline: $deadline)';
  }

  @override
  bool operator ==(covariant Job other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.jobTitle == jobTitle &&
        other.workingMode == workingMode &&
        other.description == description &&
        other.location == location &&
        other.jobType == jobType &&
        other.time == time &&
        other.jobId == jobId &&
        other.isOpened == isOpened &&
        other.companyId == companyId &&
        listEquals(other.applicationReceived, applicationReceived) &&
        other.salary == salary &&
        listEquals(other.responsibilities, responsibilities) &&
        listEquals(other.requirement, requirement) &&
        listEquals(other.benefits, benefits) &&
        other.deadline == deadline;
  }

  @override
  int get hashCode {
    return jobTitle.hashCode ^
        workingMode.hashCode ^
        description.hashCode ^
        location.hashCode ^
        jobType.hashCode ^
        time.hashCode ^
        jobId.hashCode ^
        isOpened.hashCode ^
        companyId.hashCode ^
        applicationReceived.hashCode ^
        salary.hashCode ^
        responsibilities.hashCode ^
        requirement.hashCode ^
        benefits.hashCode ^
        deadline.hashCode;
  }
}
