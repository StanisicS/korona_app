// Object appRoutes = {
//   '/': (context) => HomeView(),
// //  '/auth': (context) => Router(),

// // // pages
// //   '/splash': (context) => SplashScreenPage(),
// //   '/refer-a-friend': (context) => ReferAFriendPage(),
// //   '/about': (context) => AboutPage(),
// //   '/rate-app': (context) => RateApp(),
// //   '/flutter-tips': (context) => FlutterTipsPage(),

// //   // auth
// //   '/login': (context) => LoginPage(),
// //   '/dashboard': (context) => DashboardPage(),

// //   // backend
// };

import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String navigator = "/";
  static const String home = "/home";
  static const String map = "/map";
  // static const String post = "post";
  // static const String style = "style";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
