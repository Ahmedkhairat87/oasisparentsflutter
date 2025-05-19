import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasisparents/core/reusable_components/app_colors_extension.dart';
import 'package:oasisparents/core/strings_manager.dart';
import 'package:oasisparents/ui/home_screen/home_screen.dart';

import '../../drawer/about_us.dart';
import '../../drawer/appointments.dart';
import '../../drawer/bus_registeration.dart';
import '../../drawer/canteen_charge.dart';
import '../../drawer/gallery.dart';
import '../../drawer/messages.dart';
import '../../drawer/newsletter.dart';
import '../../drawer/payment_Information.dart';
import '../../drawer/policies.dart';
import '../../drawer/settings.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.bubbleMedium.withOpacity(0.3),
                  Theme.of(context).colorScheme.modeGradient.withOpacity(0.1),
                ],
              ),
            ),
          ),

          // Top-left animated bubble
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: -50 + (10 * (1 - _controller.value)),
                left: -50 + (10 * (1 - _controller.value)),
                child: Opacity(
                  opacity: _controller.value,
                  child: Transform.scale(
                    scale: 0.8 + 0.2 * _controller.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.bubbleMedium.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Bottom-right animated bubble
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: -60 + (10 * (1 - _controller.value)),
                right: -60 + (10 * (1 - _controller.value)),
                child: Opacity(
                  opacity: _controller.value,
                  child: Transform.scale(
                    scale: 0.8 + 0.2 * _controller.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.bubbleLarge.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Drawer content
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Text(
                  'Hello!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.textMain,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(StringsManager.settings.tr()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Settings.routeName);
                },
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //messageBTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Messages.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.greenAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent,
                                  ),
                                  child: Icon(Icons.message,
                                  size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.messages.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //messageBTN Ends Here

                      //NewsLetterBTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Newsletter.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.brown.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.brown,
                                  ),
                                  child: Icon(Icons.newspaper,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.newsLetter.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //NewsLetterBTN Ends Here
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Payment Information BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PaymentInformation.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.cyan.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.cyan,
                                  ),
                                  child: Icon(Icons.payment,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.paymentInfo.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Payment Information BTN Ends Here

                      //Canteen Charge BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CanteenCharge.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.redAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.redAccent,
                                  ),
                                  child: Icon(Icons.restaurant_menu_rounded,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.canteenCharge.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Canteen Charge BTN Ends Here
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      //Appointment BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Appointments.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.purpleAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purpleAccent,
                                  ),
                                  child: Icon(Icons.edit_calendar,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.appointment.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Appointment BTN Ends Here
                      //Gallery BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Gallery.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  child: Icon(Icons.photo_camera_back,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.gallery.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Gallery BTN Ends Here
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Bus Registration BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, BusRegisteration.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Icon(Icons.bus_alert,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.busRegister.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Bus Registration BTN Starts Here
                      //Policies BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Policies.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: Icon(Icons.policy_outlined,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.policies.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Policies BTN Ends Here
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //About Us BTN Starts Here
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AboutUs.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.teal.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.teal,
                                  ),
                                  child: Icon(Icons.account_balance_outlined,
                                    size:35.sp,
                                  ),
                                ),
                                Text(
                                  StringsManager.aboutUs.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.textMain,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //About Us BTN Ends Here

                      //Old Settings BTN Starts Here
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     width: 100.w,
                      //     height: 100.h,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.rectangle,
                      //       color: Colors.blue.withOpacity(0.5),
                      //       borderRadius: BorderRadius.all(Radius.circular(25)),
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Container(
                      //           width: 50.w,
                      //           height: 50.h,
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.blue,
                      //           ),
                      //           child: Icon(Icons.settings,
                      //             size:35.sp,
                      //           ),
                      //         ),
                      //         Text(
                      //           StringsManager.settings.tr(),
                      //           style: TextStyle(
                      //             fontSize: 13.sp,
                      //             fontWeight: FontWeight.bold,
                      //             color: Theme.of(context).colorScheme.textMain,
                      //             fontFamily: 'Roboto',
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //Old Settings BTN Ends Here
                      //placeHolder Starts Here
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.textMain,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //PlaceHolder Ends Here
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
