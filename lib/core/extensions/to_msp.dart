import 'package:flutter/material.dart';

extension ColorExtension on Color {
  MaterialStateProperty<Color?> toMSP() {
    return MaterialStateProperty.resolveWith<Color?>(
      (states) => this,
    );
  }
}
