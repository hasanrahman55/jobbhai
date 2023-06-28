import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

import '../../../../../constants/app_svg.dart';
import '../../../../../theme/colors.dart';
import '../../post_job/views/post_jobs_screen/jobs_screen.dart';
import '../../recruiter_profile/recruiter_profile_screen.dart';
import 'recruiter_home.dart';

class RecruiterPageNavigator extends StatefulWidget {
  const RecruiterPageNavigator({super.key});

  @override
  RecruiterPageNavigatorState createState() => RecruiterPageNavigatorState();
}

class RecruiterPageNavigatorState extends State<RecruiterPageNavigator> {
  int _selectedIndex = 1;

  static List<Widget> pages = [
    const RecruiterHomeView(),
    const JobsScreen(),
    const RecruiterProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppSvg.briefcaseLight),
              activeIcon: SvgPicture.asset(
                AppSvg.briefcaseBold,
                color: AppColors.primaryColor,
              ),
              label: 'Jobs',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(IconlyLight.bookmark),
            //   activeIcon: Icon(IconlyBold.bookmark),
            //   label: 'Saved',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              activeIcon: Icon(IconlyBold.profile),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
