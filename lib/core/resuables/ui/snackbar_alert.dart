import 'package:flutter/material.dart';

void snackBarAlert(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Row(
        children: [
          const Icon(Icons.info, color: Colors.white),
          const SizedBox(
              width: 8), // add a bit of spacing between the icon and the text
          Expanded(
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
