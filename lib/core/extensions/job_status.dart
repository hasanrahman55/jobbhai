import 'package:jobbhai/core/enums/application_status.dart';

extension JobType on String {
  ApplicationStatus applicationStatus() {
    return switch (this) {
      'Review' => ApplicationStatus.review,
      'Accepted' => ApplicationStatus.accepted,
      'Rejected' => ApplicationStatus.rejected,
      _ => ApplicationStatus.review,
    };
  }
}
