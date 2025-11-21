// lib/ui/home_screen/widgets/student_inside.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/academic_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/athletics_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/forms_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/meals_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/medical_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/profile_tab.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside_tabs/schedule_tab.dart';

import '../../../core/reusable_components/app_background.dart';
import '../../../core/reusable_components/studentInside_tabbar.dart'; // GoldenTabBar + TabItem
import '../../../core/reusable_components/students_inside_tabs.dart'; // StudentTabPages

class StudentInside extends StatefulWidget {
  const StudentInside({super.key});

  static const routeName = '/studentInside';

  @override
  State<StudentInside> createState() => _StudentInsideState();
}

class _StudentInsideState extends State<StudentInside>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final ScrollController _tabsScrollController;
  int _selectedIndex = 0;

  // Tab metadata
  final List<TabItem> _tabs = const [
    TabItem(title: "Profile", icon: Icons.person),
    TabItem(title: "Academic", icon: Icons.school),
    TabItem(title: "Athletics", icon: Icons.sports_soccer),
    TabItem(title: "Meals", icon: Icons.restaurant),
    TabItem(title: "Medical", icon: Icons.medical_services),
    /*TabItem(title: "Messages", icon: Icons.message),*/
    TabItem(title: "Forms", icon: Icons.description),
    TabItem(title: "Schedule", icon: Icons.schedule),
  ];

  @override
  void initState() {
    super.initState();
    _tabsScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabsScrollController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutQuad,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // Pages for PageView / StudentTabPages
    final pages = <Widget>[
      const ProfileTab(),
      AcademicTab(), // non-const
      const AthleticsTab(),
      const MealsTab(),
      const MedicalTab(),
      /*const MessagesTab(),*/
      const FormsTab(),
      const ScheduleTab(),
    ];

    return Scaffold(
      // 👉 Keep layout simple & constrained: no extendBodyBehindAppBar here
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "student".tr(),
          style: const TextStyle(color: Colors.black),
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ),
      ),
      body: AppBackground(
        useAppBarBlur: false, // we already blur in AppBar itself
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 8.h),

            // joyful GoldenTabBar (already themed)
            GoldenTabBar(
              tabs: _tabs,
              selectedIndex: _selectedIndex,
              onTap: _onTabTap,
              controller: _tabsScrollController,
              tabWidth: 120,
            ),

            SizedBox(height: 8.h),

            // main pages area -> takes all remaining height, so NO overflow
            Expanded(
              child: StudentTabPages(
                pages: pages,
                controller: _pageController,
                onPageChanged: _onPageChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}