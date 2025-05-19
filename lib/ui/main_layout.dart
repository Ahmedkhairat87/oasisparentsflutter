import 'package:flutter/material.dart';

import 'home_screen/widgets/home_drawer.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(),
    );
  }
}
