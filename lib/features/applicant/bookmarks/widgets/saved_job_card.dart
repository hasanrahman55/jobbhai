import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/features/recruiter/post_job/controller/post_job_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../common/info_chip.dart';
import '../../../../../common/svg_icon_mini.dart';
import '../../../../../constants/app_svg.dart';
import '../../../../../theme/colors.dart';

class SavedJobCard extends ConsumerStatefulWidget {
  final String jobId;

  final bool isBookmarked;
  final String imageUrl;
  const SavedJobCard({
    Key? key,
    required this.jobId,
    required this.isBookmarked,
    required this.imageUrl,
  }) : super(key: key);

  @override
  ConsumerState<SavedJobCard> createState() => _SavedJobCardState();
}

class _SavedJobCardState extends ConsumerState<SavedJobCard> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    return ref.watch(myPostedJobProvider(widget.jobId)).when(
        data: (job) {
          final companyDetails =
              ref.watch(recruiterProfileDetailsProvider(job.companyId)).value;

          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          companyDetails!.logoUrl,
                          fit: BoxFit.contain,
                          height: 45,
                          width: 45,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(
                          job.jobTitle,
                          style: textStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: const Icon(IconlyBold.bookmark,
                          color: AppColors.primaryColor),
                      subtitle: Row(
                        children: [
                          const SvgIconMini(svg: AppSvg.locationLight),
                          const SizedBox(width: 5),
                          Text(
                            job.location,
                            style: textStyle.copyWith(fontSize: 12),
                          ),
                          const SizedBox(width: 10),
                          const SvgIconMini(svg: AppSvg.briefcaseLight),
                          const SizedBox(width: 5),
                          Text(
                            job.jobType,
                            style: textStyle.copyWith(fontSize: 12),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoChip(
                          title: job.isOpened ? 'Open' : 'Closed',
                          titleColor: job.isOpened ? Colors.green : Colors.blue,
                        ),
                        InfoChip(
                            title: timeago.format(job.time),
                            titleColor: Colors.grey[800]!),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        error: (error, trace) => const SizedBox(),
        loading: () => const SizedBox());
  }
}
