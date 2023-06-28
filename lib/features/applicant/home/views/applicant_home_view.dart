// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/common/searchbox.dart';
import 'package:jobbhai/common/verticalbar_decoration.dart';
import 'package:jobbhai/constants/category_data.dart';
import 'package:jobbhai/features/applicant/home/views/all_jobs.dart';
import 'package:jobbhai/features/applicant/home/widgets/category_icon.dart';
import 'package:jobbhai/features/applicant/home/widgets/recent_job_card.dart';
import 'package:jobbhai/features/recruiter/post_job/controller/post_job_controller.dart';
import 'package:jobbhai/model/job.dart';
import 'package:jobbhai/routes/app_route.dart';
import 'package:jobbhai/theme/colors.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<Job> recentsJobs = [];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Hi there 👋🏽'
            // style: txtStyle!.copyWith(fontSize: 13),
            ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.notification
                  // color: Colors.grey,
                  ))
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoute.jobSearch),
                child: const SearchBox(
                  enableInput: false,
                ),
              ),
              const SizedBox(height: 10),
              VerticalBar(title: 'Tips for you'),
              TipsForYouCard(textStyle: textStyle),
              const SizedBox(height: 20),
              VerticalBar(title: 'Category'),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryIcons(
                      iconColor: categoryData[index].iconColor,
                      title: categoryData[index].category,
                      icon: categoryData[index].icon,
                    );
                  },
                ),
              ),
              VerticalBar(
                title: 'Recent Jobs',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllJobsList(
                            jobs: ref.watch(postedJobProvider).value!))),
              ),

              const SizedBox(height: 10),

              ref.watch(postedJobProvider).when(
                    data: (data) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        shrinkWrap: true,
                        itemCount: data.length < 6 ? data.length : 5,
                        itemBuilder: (BuildContext context, int index) {
                          return data[index].isOpened
                              ? RecentJobCard(
                                  job: data[index],
                                  imageBackground: Colors.transparent,
                                )
                              : const SizedBox();
                        },
                      );
                    },
                    error: (error, st) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
              // ListView.separated(
              //   physics: const NeverScrollableScrollPhysics(),
              //   separatorBuilder: (context, index) =>
              //       const SizedBox(height: 15),
              //   shrinkWrap: true,
              //   itemCount: jobsData.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return RecentJobCard(
              //       id: jobsData[index].id,
              //       type: jobsData[index].type,
              //       title: jobsData[index].title,
              //       isSaved: jobsData[index].isSaved,
              //       location: jobsData[index].location,
              //       imageUrl: jobsData[index].imageUrl,
              //       imageBackground: jobsData[index].imageBackground,
              //     );
              //   },
              // ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}

class TipsForYouCard extends StatelessWidget {
  const TipsForYouCard({
    super.key,
    required this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to create a\nperfect cv for you',
                style:
                    textStyle!.copyWith(fontSize: 16, color: Colors.grey[50]),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: () {},
                color: Colors.white,
                child: Text(
                  'Details',
                  style: textStyle!.copyWith(
                      fontSize: 17,
                      color: AppColors.primaryColor.withOpacity(0.8)),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -2,
          right: 24,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor.withOpacity(0.5),
            radius: 70,
          ),
        ),
        Positioned(
          bottom: -30,
          right: 0,
          // alignment: Alignment.bottomRight,
          child: Image.asset(
            'assets/images/image2.png',
            width: 180,
            height: 200,
          ),
        ),
      ]),
    );
  }
}
