enum ApplicationStatus {
  review('Review'),
  accepted('Accepted'),
  rejected('Rejected');

  final String text;
  const ApplicationStatus(this.text);
}
