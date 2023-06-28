import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobbhai/routes/app_route.dart';

import '../../../../../../constants/app_svg.dart';
import '../../../../../../theme/colors.dart';
import 'active_jobs.dart';
import 'closed_jobs.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  JobsScreenState createState() => JobsScreenState();
}

class JobsScreenState extends State<JobsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ActiveJobsView(),
    const ClosedJobsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('My Jobs'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton<int>(
                style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                        BorderSide(color: AppColors.primaryColor))),
                showSelectedIcon: false,
                selected: {_selectedIndex},
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Active'),
                    enabled: true,
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Closed'),
                    enabled: true,
                  ),
                ],
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedIndex = newSelection.first;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        splashColor: Colors.white,
        backgroundColor: Colors.white,
        onPressed: () => Navigator.of(context).pushNamed(AppRoute.postAJobView),
        child:
            SvgPicture.asset(AppSvg.addBroken, color: AppColors.primaryColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
