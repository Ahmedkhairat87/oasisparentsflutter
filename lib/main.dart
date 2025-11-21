import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasisparents/ui/drawer/about_us.dart';
import 'package:oasisparents/ui/drawer/appointments.dart';
import 'package:oasisparents/ui/drawer/bus_registeration.dart';
import 'package:oasisparents/ui/drawer/canteen_charge.dart';
import 'package:oasisparents/ui/drawer/gallery.dart';
import 'package:oasisparents/ui/drawer/messages.dart';
import 'package:oasisparents/ui/drawer/newsletter.dart';
import 'package:oasisparents/ui/drawer/payment_Information.dart';
import 'package:oasisparents/ui/drawer/policies.dart';
import 'package:oasisparents/ui/drawer/settings.dart';
import 'package:oasisparents/ui/home_screen/home_screen.dart';
import 'package:oasisparents/ui/home_screen/widgets/student_inside.dart';
import 'package:oasisparents/ui/login_screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  String startRoute = (token == null || token.isEmpty) ? LoginScreen.routeName : HomeScreen.routeName;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(initialRoute: startRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Oasis Parents',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppStyle.lightMode,
          darkTheme: AppStyle.darkMode,
          initialRoute: initialRoute,
          routes: {
            HomeScreen.routeName: (_) => HomeScreen(),
            LoginScreen.routeName: (_) => LoginScreen(),
            Settings.routeName: (_) => Settings(),
            AboutUs.routeName: (_) => AboutUs(),
            Policies.routeName: (_) => Policies(),
            BusRegisteration.routeName: (_) => BusRegisteration(),
            Gallery.routeName: (_) => Gallery(),
            Appointments.routeName: (_) => Appointments(),
            CanteenCharge.routeName: (_) => CanteenCharge(),
            PaymentInformation.routeName: (_) => PaymentInformation(),
            Newsletter.routeName: (_) => Newsletter(),
            Messages.routeName: (_) => Messages(),
            StudentInside.routeName: (_) => StudentInside(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}