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
import 'package:oasisparents/ui/login_screen/login.dart';

import 'core/app_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //==> ScreenUtil attributes Starts Here <==//
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      //==> ScreenUtil attributes Ends Here <==//
      builder: (context, child) {
        return MaterialApp(
            title: 'Oasis Parents',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppStyle.lightMode,
            darkTheme: AppStyle.darkMode,
            home: const  HomeScreen(),
            //==> Routes Starts Here <==//
            initialRoute: LoginScreen.routeName,
            routes: {HomeScreen.routeName: (_) => HomeScreen(),
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
              //==> Routes Ends Here <==//
            },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
