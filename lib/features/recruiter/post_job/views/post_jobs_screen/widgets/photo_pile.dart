// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/post_job_controller.dart';

class PhotoPileWidget extends ConsumerWidget {
  final String jobId;
  final double? avatarSize;
  final double? overlapDistance;
  const PhotoPileWidget(
    this.jobId, {
    super.key,
    this.avatarSize,
    this.overlapDistance,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(applicantsImageProvider(jobId));
    return images.when(
        data: (data) => PhotoPile(
            images: data,
            avatarSize: avatarSize,
            overlapDistance: overlapDistance),
        error: (e, st) => const SizedBox(),
        loading: () => const SizedBox());
  }
}

class PhotoPile extends StatelessWidget {
  final List<String> images;
  final double? avatarSize;
  final double? overlapDistance;

  const PhotoPile({
    Key? key,
    required this.images,
    this.avatarSize,
    this.overlapDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _avatarSize = avatarSize ?? 20;
    final _overlapDistance = overlapDistance ?? 12.0;
    int remaining = images.length > 4 ? images.length - 3 : 0;
    List<Widget> widgets = [];

    for (var i = 0; i < (images.length > 4 ? 3 : images.length); i++) {
      widgets.add(Positioned(
        left: i * _overlapDistance,
        child: CircleAvatar(
          radius: _avatarSize / 2,
          backgroundImage: NetworkImage(images[i]),
        ),
      ));
    }

    if (remaining > 0) {
      widgets.add(
        Positioned(
          left: 3 * _overlapDistance,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '+$remaining',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: _avatarSize + (min(3, images.length) * _overlapDistance),
      height: _avatarSize,
      child: Stack(
        children: widgets,
      ),
    );
  }
}
