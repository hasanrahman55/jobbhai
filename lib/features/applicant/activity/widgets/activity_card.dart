// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../common/company_logo.dart';
import '../../../../../common/info_chip.dart';
import '../../../../../common/svg_icon_mini.dart';
import '../../../../../constants/app_svg.dart';
import '../../../../../core/enums/enums.dart';

class ActivityCard extends StatelessWidget {
  final int id;
  final WorkType type;
  final String title;
  final String company;
  final String location;
  final String imageUrl;
  final String salary;
  // final String chipText;
  // final Color chipColor;
  final Color imageBackground;
  const ActivityCard({
    Key? key,
    required this.id,
    required this.type,
    required this.title,
    required this.company,
    required this.location,
    required this.imageUrl,
    required this.salary,
    // required this.chipText,
    // required this.chipColor,
    required this.imageBackground,
  }) : super(key: key);

  // final TextStyle? textStyle;
  // void selectJob(BuildContext context) {
  //   Navigator.of(context).pushNamed(
  //     JobDetailScreen.routeName,
  //     arguments: id,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    int randomIndex = Random().nextInt(4);

    List infoChipTextAndColor = [
      ['Accepted', Colors.green],
      ['Pending', Colors.amber[600]],
      ['Rejected', Colors.red],
      ['Interview', Colors.cyan]
    ];

    return GestureDetector(
      // onTap: (() => selectJob(context)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            )),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: CompanyLogo(
                  imageUrl: imageUrl,
                  size: 40,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    company,
                    style: textStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: const Icon(Icons.more_vert, color: Colors.grey),
                subtitle: Row(
                  children: [
                    const SvgIconMini(svg: AppSvg.locationLight),

                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: textStyle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    const SvgIconMini(svg: AppSvg.briefcaseLight),
                    // const Icon(IconlyLight.bag_2, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      type.text,
                      style: textStyle.copyWith(fontSize: 13),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                title,
                style: textStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    textBaseline: TextBaseline.ideographic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      const SvgIconMini(svg: AppSvg.dollarLight),
                      const SizedBox(width: 5),
                      Text('${salary}k/month')
                    ],
                  ),
                  InfoChip(
                    title: infoChipTextAndColor[randomIndex][0],
                    titleColor: infoChipTextAndColor[randomIndex][1],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}
