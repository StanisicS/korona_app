import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'utils/navigator.dart';

import 'repository/corona_bloc.dart';
import 'views/gmap_view.dart';
import 'utils/package_Info.dart';
import 'utils/kolorz.dart';
import 'utils/router.dart';

import 'package:catcher/catcher.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:device_simulator/device_simulator.dart';
// import 'package:responsive_screen/responsive_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'gmap.dart';
// import 'package:location/location.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:geolocator/geolocator.dart';
// import './models/serbia.dart';
// import 'package:getflutter/getflutter.dart';
// import './responsive/responsive_builder.dart';

// Future<void> main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await init();
//   runMyApp();
// }

// main() {
//   //debug configuration
//   CatcherOptions debugOptions =
//       CatcherOptions(SilentReportMode(), [ConsoleHandler()]);

//   //release configuration
//   CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
//     EmailManualHandler(["stevan.stanisic@outlook.com"])
//   ]);

//   //MyApp is root widget
//   Catcher(MyApp(),
//       debugConfig: debugOptions,
//       releaseConfig: releaseOptions
//   );
// }

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(MyApp());
}

Future<void> init() async {
  CoronaBloc();
  await initPackageInfo();
}

// const bool debugEnableDeviceSimulator = true;

// void runMyApp() {
//   runZoned<Future<void>>(
//     () async {
//       runApp(
//         MyApp(),
//       );
//     },
//     onError: (dynamic error, StackTrace stackTrace) async {
// //      await FireBaseManager().logException(
// //        error,
// //        stackTrace: stackTrace,
// //      );
//     },
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      title: 'Covid-19 Ambulante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryDark,
        accentColor: kSecondary,
        scaffoldBackgroundColor: kBackground,
        canvasColor: Colors.transparent,
        // fontFamily: '${GoogleFonts.sourceCodePro()}'),
        fontFamily: 'Nexa Text Demo',
        // theme: ThemeData.dark().copyWith(
        //   primaryColor: kPrimaryDark,
        //   scaffoldBackgroundColor: kBackground,
        //   canvasColor: Colors.transparent,
        //   textTheme:
        //       GoogleFonts.sourceCodeProTextTheme(Theme.of(context).textTheme),
      ),
      // home: HomeView(title: 'Covid-19 Ambulante'),
      initialRoute: Routes.navigator,
      routes: {
        Routes.navigator: (context) => AppNavigator(),
        Routes.home: (context) => GmapView(),
        Routes.map: (context) => GmapView(),
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   return Routes.fadeThrough(settings, (context) {
      // switch (settings.name) {
      //   case Routes.home:
      //     return ListPage();
      //     break;
      //   case Routes.post:
      //     return PostPage();
      //     break;
      //   case Routes.style:
      //     return TypographyPage();
      //     break;
      //   default:
      //     return null;
      //     break;
      // }
      //     if (settings.name == Routes.home) {
      //       return HomeView();
      //     }
      //   });
      // },
      // onGenerateRoute: (RouteSettings settings) {
      //   return Routes.fadeThrough(settings, (context) {
      //     switch (settings.name) {
      //       case Routes.home:
      //         return ListPage();
      //         break;
      //       case Routes.post:
      //         return PostPage();
      //         break;
      //       case Routes.style:
      //         return TypographyPage();
      //         break;
      //       default:
      //         return null;
      //         break;
      //     }
      //   });
      // },
      // home: DeviceSimulator(
      //   brightness: Brightness.dark,
      //   enable: debugEnableDeviceSimulator,
      //   child: HomeView(),
      // initialRoute: '/',
      // routes: appRoutes,
      // )
    );
  }

  void dispose() {
    CoronaBloc().dispose();
    // super.dispose();
  }
}
