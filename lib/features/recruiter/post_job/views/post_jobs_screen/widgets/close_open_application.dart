import 'package:flutter/material.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';

void closeOrOpenApplicationDialog({
  required BuildContext context,
  required bool jobStatus,
  required Function() onTap,
}) =>
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: onTap,
                        child: CustomText(
                          text: jobStatus
                              ? 'Close  Application'
                              : 'Open Application',
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
