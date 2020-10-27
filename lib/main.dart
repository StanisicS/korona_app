import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'utils/navigator.dart';

import 'repository/corona_bloc.dart';
import 'views/gmap_view.dart';
import 'views/home_view.dart';
import 'views/news_view.dart';
import 'utils/package_Info.dart';
import 'utils/kolorz.dart';
import 'utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kPrimaryDark,
    statusBarColor: Colors.pink,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.greenAccent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  await init();
  runMyApp();
}

Future<void> init() async {
  CoronaBloc();
  await initPackageInfo();
}

void runMyApp() {
  runZoned<Future<void>>(
    () async {
      runApp(
        MyApp(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('sr', ''),
      ],
      builder: (context, widget) => ResponsiveWrapper.builder(widget,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      // title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryDark,
        accentColor: kSecondary,
        scaffoldBackgroundColor: kBackground,
        canvasColor: Colors.transparent,
        fontFamily: 'Comfortaa',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: kPrimaryDark,
          shadowColor: const Color(0xff050814),
          textTheme: TextTheme(
            headline6: TextStyle(
                letterSpacing: 1.6,
                fontSize: 26.0,
                fontFamily: 'Comfortaa',
                color: kTextDark,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      initialRoute: Routes.navigator,
      routes: {
        Routes.navigator: (context) => AppNavigator(),
        Routes.home: (context) => HomeView(),
        Routes.map: (context) => GMapView(),
        Routes.news: (context) => NewsView(),
      },
    );
  }

  void dispose() {
    CoronaBloc().dispose();
  }
}
