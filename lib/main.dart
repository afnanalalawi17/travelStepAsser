import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:travel_step/view/boarding.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';
import 'package:travel_step/view/home.dart';
import 'package:travel_step/view/login.dart';
import 'package:travel_step/view/map.dart';
import 'package:travel_step/view/naroAI.dart';
import 'package:travel_step/view/reservation.dart';
import 'package:travel_step/view/signup.dart';
import 'package:travel_step/view/travelPlanner.dart';
import 'package:travel_step/view/wallet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:showcaseview/showcaseview.dart'; // ✅ أضف هذا
import 'package:travel_step/view/boarding.dart';

void main() async {
  runApp(
    ShowCaseWidget(
      builder: Builder(
        builder: (context) => GetMaterialApp(
          theme: ThemeData(
            dividerColor: Colors.transparent,
            primaryColor: Color(0xff764880),
            scaffoldBackgroundColor: Colors.white,
            shadowColor: Colors.white,
            fontFamily: 'IBMPlexSansArabic',
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
          ],
          locale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          home: OnboardingScreen(),
          getPages: [],
        ),
      ),
    ),
  );
}
