import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewCv extends ConsumerWidget {
  final String applicantName;
  final String filePath;
  const ViewCv(
      {super.key, required this.applicantName, required this.filePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant  CV')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: PDFView(
          filePath: filePath,
        ),
      ),
    );
  }
}
