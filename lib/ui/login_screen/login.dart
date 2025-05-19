import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasisparents/core/reusable_components/app_colors_extension.dart';
import 'package:oasisparents/core/reusable_components/text_field.dart';

import '../../core/assets_manager.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userController;
  late TextEditingController passController;
  late TextEditingController mailController;
  late GlobalKey<FormState> formKey;

  static const String passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const String emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";

  //==> Void InitState Starts Here <==//
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    userController = TextEditingController();
    passController = TextEditingController();
    mailController = TextEditingController();
  }
  //==> Void InitState Starts Here <==//

  //==> Void dispose Starts Here <==//
  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    mailController.dispose();
    super.dispose();
  }
  //==> Void dispose Starts Here <==//

  //==> Build Widget Starts Here <==//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //==> Stack Starts Here <==//
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          //==> Background Starts Here <==//
          //Image.asset("assets/images/loginbg.png", fit: BoxFit.cover),
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Color(0xFFB0CBEF),
                    //Theme.of(context).colorScheme.onSecondaryContainer,
                    //Colors.white,
                    Theme.of(context).colorScheme.bubbleMedium,
                    Theme.of(context).colorScheme.modeGradient,
                  ],
                ),
              ),
            ),
          ),

          // Top-left small bubble
          Positioned(
            top: 40,
            left: 50,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Color(0xFFB0CBEF),
                    Theme.of(context).colorScheme.bubbleMedium,
                    Theme.of(context).colorScheme.modeGradient,
                    //Colors.white,
                  ],
                ),
              ),
            ),
          ),

          // Bottom-right large bubble
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Color(0xFF6094DD),
                    Theme.of(context).colorScheme.bubbleLarge,
                    Theme.of(context).colorScheme.modeGradient,
                    //Colors.white,
                  ],
                ),
              ),
            ),
          ),
          //==> Background Ends Here <==//
          //==>  Language Button Starts <==//
          Positioned(
            top: 40,
            right: 20,
            child: PopupMenuButton<Locale>(
              icon: const Icon(Icons.language, color: Colors.blue),
              onSelected: (Locale locale) {
                context.setLocale(locale); // ✅ Switches the app's language
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: Locale('en'),
                  child: Text('🇬🇧 English'),
                ),
                PopupMenuItem(
                  value: Locale('fr'),
                  child: Text('🇫🇷 Français'),
                ),
              ],
            ),
          ),
          //==>  Language Button Ends Here <==//
          //==>  Column Starts Here <==//
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //==>  Logo Starts Here <==//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset(AssetsManager.logo, width: 200.w)],
                    ),
                    //==>  Logo Ends Here <==//
                    SizedBox(height: 30.h),
                    //==> Welcome Text Starts Here <==//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "welcome".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.textMain,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    //==> Welcome Text Ends Here <==//
                    SizedBox(height: 15,),
                    //==> Sign In Text Starts Here <==//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "sign_in".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.textMain,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    //==> Sign In Text Ends Here <==//
                    SizedBox(
                      height: 20.h,
                    ),
                    //==> User Name Text Field Starts Here <==//
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      child: CustomTextField(
                        hint: "enter_user_id".tr(),
                        hintIcon: Icons.person,
                        controller: userController,
                        keyboardType: TextInputType.number,
                        validator: (p0) {
                          return null;
                        },
                      ),
                    ),
                    //==> User Name Text Field Ends <==//

                    //==> Password Text Field Starts <==//
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 8.h,
                      ),
                      child: CustomTextField(
                        hint: "enterPassword".tr(),
                        hintIcon: Icons.lock,
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "empty_password".tr();
                          }
                          if (!RegExp(passwordRegex).hasMatch(value)) {
                            return "not_valid_password".tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    //==> Password Text Field Ends <==//

                    //==>  Forget Password Text Starts Here <==//
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap:
                                //==>  Bottom Sheet Starts Here <==//
                                () => showModalBottomSheet(
                                  context: context,
                                  builder:
                                      (context) => Container(
                                        height: MediaQuery.of(context).size.height * 0.9,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.backgroundMain,
                                        child: Column(
                                          children: [
                                            //==> Custom AppBar Starts Here <==//
                                            Container(
                                              height: 56.h,
                                              decoration: BoxDecoration(
                                                color:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .backgroundMain,
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                      top: Radius.circular(20),
                                                    ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "reset".tr(),
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .textMain,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.close),
                                                    onPressed:
                                                        () => Navigator.pop(
                                                          context,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //==> Custom AppBar Ends Here <==//
                                            SizedBox(
                                              height: 50.h,
                                            ),
                                            //==> Bottom Sheet Custom Text Field Starts <==//
                                            SizedBox(
                                              width: 350.w,
                                              child: CustomTextField(
                                                hint: "enter_email".tr(),
                                                hintIcon: Icons.email,
                                                controller: mailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "empty_email".tr();
                                                  }
                                                  if (!RegExp(
                                                    emailRegex,
                                                  ).hasMatch(value)) {
                                                    return "not_valid_email".tr();
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            //==> Bottom Sheet Custom Text Field Ends <==//
                                            SizedBox(height: 20.h),
                                            //==> Bottom Sheet Reset Note Starts <==//
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 350.w,
                                                child: Text("reset_note".tr(),
                                                  softWrap: true,
                                                  overflow: TextOverflow.visible,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .textMain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //==> Bottom Sheet Reset Note Ends <==//
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            //==> Bottom Sheet Button Starts <==//
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .elements,
                                                        minimumSize: Size(
                                                          330.w,
                                                          40.h,
                                                        ),
                                                      ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "reset".tr(),
                                                    style: TextStyle(
                                                      color:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .textMain,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //==> Bottom Sheet Button Ends Here <==//
                                            //==> Bottom Sheet Ends Here <==//
                                          ],
                                        ),
                                      ),
                                ),
                            child: Text("forget_password".tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,

                                color: Theme.of(context).colorScheme.textMain,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //==> Forget Password Text Ends Here <==//
                    SizedBox(
                      height: 50.h,
                    ),
                    //==> Login Button Starts Here <==//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.elements,
                            minimumSize: Size(330.w, 40.h),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          },
                          child: Text(
                            "login".tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.textMain,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    //==> Login Button Ends Here <==//
                  ],
                ),
              ),
            ),
          ),
          // Column Ends
        ],
      ),
    );
    // Stack Ends
  }

  //==> Build Widget Ends Here <==//
}
