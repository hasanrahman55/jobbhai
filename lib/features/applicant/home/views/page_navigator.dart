import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../activity/activity_screen.dart';
import '../../bookmarks/saved_jobs_screen.dart';
import '../../profile/profile_screen.dart';
import 'applicant_home_view.dart';

class ApplicantPageNavigator extends StatefulWidget {
  const ApplicantPageNavigator({super.key});

  @override
  ApplicantPageNavigatorState createState() => ApplicantPageNavigatorState();
}

class ApplicantPageNavigatorState extends State<ApplicantPageNavigator> {
  int _selectedIndex = 0;

  static List<Widget> pages = [
    const Home(),
    const ActivityScreen(),
    const SavedJobsScreen(),
    const ProfileScreen(),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              activeIcon: Icon(IconlyBold.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.activity),
              activeIcon: Icon(IconlyBold.activity),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.bookmark),
              activeIcon: Icon(IconlyBold.bookmark),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
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
