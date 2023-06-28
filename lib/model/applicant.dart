import 'dart:convert';

import 'package:flutter/foundation.dart';

class Applicant {
  final String name;
  final String email;
  final List<String> skills;
  final String title;
  final List<String> experience;
  final String about;
  final String location;
  final String profilePicture;
  final String id;
  final List<String> appliedJobs;
  final List<String> savedJobs;
  final List<String> applications;
  Applicant({
    required this.name,
    required this.email,
    required this.skills,
    required this.title,
    required this.experience,
    required this.about,
    required this.location,
    required this.profilePicture,
    required this.id,
    required this.appliedJobs,
    required this.savedJobs,
    required this.applications,
  });

  Applicant copyWith({
    String? name,
    String? email,
    List<String>? skills,
    String? title,
    List<String>? experience,
    String? about,
    String? location,
    String? profilePicture,
    String? id,
    List<String>? appliedJobs,
    List<String>? savedJobs,
    List<String>? applications,
  }) {
    return Applicant(
      name: name ?? this.name,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      title: title ?? this.title,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      location: location ?? this.location,
      profilePicture: profilePicture ?? this.profilePicture,
      id: id ?? this.id,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      savedJobs: savedJobs ?? this.savedJobs,
      applications: applications ?? this.applications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'skills': skills,
      'title': title,
      'experience': experience,
      'about': about,
      'location': location,
      'profilePicture': profilePicture,
      'appliedJobs': appliedJobs,
      'savedJobs': savedJobs,
      'applications': applications,
    };
  }

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      name: map['name'] as String,
      email: map['email'] as String,
      skills: List<String>.from(map['skills']),
      title: map['title'] as String,
      experience: List<String>.from(map['experience']),
      about: map['about'] as String,
      location: map['location'] as String,
      profilePicture: map['profilePicture'] as String,
      id: map['\$id'] as String,
      appliedJobs: List<String>.from(map['appliedJobs']),
      savedJobs: List<String>.from(map['savedJobs']),
      applications: List<String>.from(map['applications']),
    );
  }

  @override
  String toString() {
    return 'Applicant(name: $name, email: $email, skills: $skills, title: $title, experience: $experience, about: $about, location: $location, profilePicture: $profilePicture, id: $id, appliedJobs: $appliedJobs, savedJobs: $savedJobs, applications: $applications)';
  }

  @override
  bool operator ==(covariant Applicant other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        listEquals(other.skills, skills) &&
        other.title == title &&
        listEquals(other.experience, experience) &&
        other.about == about &&
        other.location == location &&
        other.profilePicture == profilePicture &&
        other.id == id &&
        listEquals(other.appliedJobs, appliedJobs) &&
        listEquals(other.savedJobs, savedJobs) &&
        listEquals(other.applications, applications);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        skills.hashCode ^
        title.hashCode ^
        experience.hashCode ^
        about.hashCode ^
        location.hashCode ^
        profilePicture.hashCode ^
        id.hashCode ^
        appliedJobs.hashCode ^
        savedJobs.hashCode ^
        applications.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Applicant.fromJson(String source) =>
      Applicant.fromMap(json.decode(source) as Map<String, dynamic>);
}
