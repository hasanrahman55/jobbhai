import 'package:collection/collection.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Recruiter {
  final String companyName;
  final String websiteLink;
  final String email;
  final String twitter;
  final String linkedIn;
  final String facebook;
  final String about;
  final String logoUrl;
  final String id;
  final List<String> postedJobs;
  Recruiter({
    required this.companyName,
    required this.websiteLink,
    required this.email,
    required this.twitter,
    required this.linkedIn,
    required this.facebook,
    required this.about,
    required this.logoUrl,
    required this.id,
    required this.postedJobs,
  });

  Recruiter copyWith({
    String? companyName,
    String? websiteLink,
    String? email,
    String? twitter,
    String? linkedIn,
    String? facebook,
    String? about,
    String? logoUrl,
    String? id,
    List<String>? postedJobs,
  }) {
    return Recruiter(
      companyName: companyName ?? this.companyName,
      websiteLink: websiteLink ?? this.websiteLink,
      email: email ?? this.email,
      twitter: twitter ?? this.twitter,
      linkedIn: linkedIn ?? this.linkedIn,
      facebook: facebook ?? this.facebook,
      about: about ?? this.about,
      logoUrl: logoUrl ?? this.logoUrl,
      id: id ?? this.id,
      postedJobs: postedJobs ?? this.postedJobs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'websiteLink': websiteLink,
      'email': email,
      'twitter': twitter,
      'linkedIn': linkedIn,
      'facebook': facebook,
      'about': about,
      'logoUrl': logoUrl,
      'postedJobs': postedJobs,
    };
  }

  factory Recruiter.fromMap(Map<String, dynamic> map) {
    return Recruiter(
        companyName: map['companyName'] as String,
        websiteLink: map['websiteLink'] as String,
        email: map['email'] as String,
        twitter: map['twitter'] as String,
        linkedIn: map['linkedIn'] as String,
        facebook: map['facebook'] as String,
        about: map['about'] as String,
        logoUrl: map['logoUrl'] as String,
        id: map['\$id'] as String,
        postedJobs: List<String>.from(map['postedJobs']));
  }

  @override
  String toString() {
    return 'Recruiter(companyName: $companyName, websiteLink: $websiteLink, email: $email, twitter: $twitter, linkedIn: $linkedIn, facebook: $facebook, about: $about, logoUrl: $logoUrl, id: $id, postedJobs: $postedJobs)';
  }

  @override
  bool operator ==(covariant Recruiter other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.companyName == companyName &&
        other.websiteLink == websiteLink &&
        other.email == email &&
        other.twitter == twitter &&
        other.linkedIn == linkedIn &&
        other.facebook == facebook &&
        other.about == about &&
        other.logoUrl == logoUrl &&
        other.id == id &&
        listEquals(other.postedJobs, postedJobs);
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        websiteLink.hashCode ^
        email.hashCode ^
        twitter.hashCode ^
        linkedIn.hashCode ^
        facebook.hashCode ^
        about.hashCode ^
        logoUrl.hashCode ^
        id.hashCode ^
        postedJobs.hashCode;
  }
}
