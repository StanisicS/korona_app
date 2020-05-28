import 'dart:async';
// import 'package:device_preview/device_preview.dart';
// import 'package:device_simulator/device_simulator.dart';
import 'package:google_maps_int/views/gmap_view.dart';
import 'package:responsive_screen/responsive_screen.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'gmap.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import './repository/corona_bloc.dart';
import './utils/package_Info.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

// import 'package:geolocator/geolocator.dart';
import './models/serbia.dart';
import './utils/kolorz.dart';
import 'package:getflutter/getflutter.dart';
import './responsive/responsive_builder.dart';
import './utils/router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utils/navigator.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runMyApp();
}

Future<void> init() async {
  CoronaBloc();
  await initPackageInfo();
}

const bool debugEnableDeviceSimulator = true;

void runMyApp() {
  runZoned<Future<void>>(
    () async {
      runApp(
        MyApp(),
      );
    },
    onError: (dynamic error, StackTrace stackTrace) async {
//      await FireBaseManager().logException(
//        error,
//        stackTrace: stackTrace,
//      );
    },
  );
}

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
        fontFamily: 'Comfortaa',
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
        Routes.home: (context) => HomeView(),
        Routes.map: (context) => GmapView(),
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   return Routes.fadeThrough(settings, (context) {
      //     // switch (settings.name) {
      //     //   case Routes.home:
      //     //     return ListPage();
      //     //     break;
      //     //   case Routes.post:
      //     //     return PostPage();
      //     //     break;
      //     //   case Routes.style:
      //     //     return TypographyPage();
      //     //     break;
      //     //   default:
      //     //     return null;
      //     //     break;
      //     // }
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
      //   // initialRoute: '/',
      //   // routes: appRoutes,
      // )
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Position position;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  final url =
      'https://github.com/StanisicS/google_maps_int/blob/master/assets/files/covid-19-ambulanteSRB.csv';

  // Future<void> getLocation() async {
  //   Position res = await Geolocator().getCurrentPosition();
  //   setState(() {
  //     position = res;
  //     // _child = _mapWidget();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Covid-19 Tracker Srbija'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),

            // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: StreamBuilder<Serbia>(
              stream: CoronaBloc().serbiaBehaviorSubject$.stream,
              builder: (context, snapshot) {
                Serbia serbia = CoronaBloc().serbia$;
                if (snapshot.hasData || serbia != null) {
                  serbia = snapshot.data ?? serbia;
                }
                String dateText = "";
                if (serbia != null && serbia.updatedDate != null) {
                  dateText = serbia.updatedDate + " " + serbia.updatedTime;
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GFListTile(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 0, right: 0),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryDark,
                      title: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'UKUPAN BROJ OBOLELIH\n',
                                style: TextStyle(
                                  color: kText,

                                  fontSize: 16,

                                  wordSpacing: -0.7,

                                  // fontFamily:

                                  //     '${GoogleFonts.sourceCodePro()}',

                                  fontFamily: 'Nexa Text Demo',
                                ),
                              ),
                              TextSpan(
                                text: '${serbia.cases}',
                                style: TextStyle(
                                  color: kYellow,
                                  fontSize: 20,
                                  fontFamily: 'Nexa Demo',
                                  fontWeight: FontWeight.w900,
                                  height: 2.0,
                                  letterSpacing: 2.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subTitle: Row(
                        children: [
                          Text(
                            'Source:\nworldometers.info/coronavirus',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kTextDark,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          if (dateText != "") ...{
                            Text(
                              'Last update:\n$dateText',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kTextDark, fontSize: 12),
                            ),
                          },
                        ],
                      ),
                    ),
                    GFListTile(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 0, right: 0),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryDark,
                      title: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'UKUPAN BROJ PREMINULIH\n',
                                style: TextStyle(
                                  color: kText,

                                  fontSize: 16,

                                  wordSpacing: -0.7,

                                  // fontFamily:

                                  //     '${GoogleFonts.sourceCodePro()}',

                                  fontFamily: 'Nexa Text Demo',
                                ),
                              ),
                              TextSpan(
                                text: '${serbia.deaths}',
                                style: TextStyle(
                                  color: kYellow,
                                  fontSize: 20,
                                  fontFamily: 'Nexa Demo',
                                  fontWeight: FontWeight.w900,
                                  height: 2.0,
                                  letterSpacing: 2.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subTitle: Row(
                        children: [
                          Text(
                            'Source:\nworldometers.info/coronavirus',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kTextDark,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          if (dateText != "") ...{
                            Text(
                              'Last update:\n$dateText',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kTextDark, fontSize: 12),
                            ),
                          },
                        ],
                      ),
                    ),
                    GFListTile(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 0, right: 0),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryDark,
                      title: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'UKUPAN BROJ IZLEČENIH\n',
                                style: TextStyle(
                                  color: kText,

                                  fontSize: 16,

                                  wordSpacing: -0.7,

                                  // fontFamily:

                                  //     '${GoogleFonts.sourceCodePro()}',

                                  fontFamily: 'Nexa Text Demo',
                                ),
                              ),
                              TextSpan(
                                text: '${serbia.recovered}',
                                style: TextStyle(
                                  color: kYellow,
                                  fontSize: 20,
                                  fontFamily: 'Nexa Demo',
                                  fontWeight: FontWeight.w900,
                                  height: 2.0,
                                  letterSpacing: 2.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subTitle: Row(
                        children: [
                          Text(
                            'Source:\nworldometers.info/coronavirus',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kTextDark,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          if (dateText != "") ...{
                            Text(
                              'Last update:\n$dateText',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kTextDark, fontSize: 12),
                            ),
                          },
                        ],
                      ),
                    ),
                    GFListTile(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 0, right: 0),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryDark,
                      title: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'BROJ OBOLELIH U POSLEDNJA 24 CASA\n',
                                style: TextStyle(
                                  color: kText,

                                  fontSize: 16,

                                  wordSpacing: -0.7,

                                  // fontFamily:

                                  //     '${GoogleFonts.sourceCodePro()}',

                                  fontFamily: 'Nexa Text Demo',
                                ),
                              ),
                              TextSpan(
                                text: '${serbia.todayCases}',
                                style: TextStyle(
                                  color: kYellow,
                                  fontSize: 20,
                                  fontFamily: 'Nexa Demo',
                                  fontWeight: FontWeight.w900,
                                  height: 2.0,
                                  letterSpacing: 2.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subTitle: Row(
                        children: [
                          Text(
                            'Source:\nworldometers.info/coronavirus',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kTextDark,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          if (dateText != "") ...{
                            Text(
                              'Last update:\n$dateText',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kTextDark, fontSize: 12),
                            ),
                          },
                        ],
                      ),
                    ),
                    GFListTile(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 0, right: 0),
                      margin: EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      //     EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      color: kPrimaryDark,
                      title: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'BROJ PREMINULIH U POSLEDNJA 24 CASA\n',
                                style: TextStyle(
                                  color: kText,

                                  fontSize: 16,

                                  wordSpacing: -0.7,

                                  // fontFamily:

                                  //     '${GoogleFonts.sourceCodePro()}',

                                  fontFamily: 'Nexa Text Demo',
                                ),
                              ),
                              TextSpan(
                                text: '${serbia.todayDeaths}',
                                style: TextStyle(
                                  color: kYellow,
                                  fontSize: 20,
                                  fontFamily: 'Nexa Demo',
                                  fontWeight: FontWeight.w900,
                                  height: 2.0,
                                  letterSpacing: 2.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subTitle: Row(
                        children: [
                          Text(
                            'Source:\nworldometers.info/coronavirus',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kTextDark,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          if (dateText != "") ...{
                            Text(
                              'Last update:\n$dateText',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: kTextDark, fontSize: 12),
                            ),
                          },
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
//   void dispose() {
//     CoronaBloc().dispose();
//     super.dispose();
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return ResponsiveBuilder(builder: (context, sizingInformation) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),

//         // color: Colors.white,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   'Registar COVID-19 ambulanti na teritoriji Republike Srbije',
//                   style: TextStyle(fontSize: 38, color: Color(0xFF8D8E98)),
//                 ),
//                 SizedBox(height: 20),
//                 //               FlatButton(
//                 //   child: Text('Tap to open file'),
//                 //   onPressed: () {
//                 //     OpenFile.open('assets/covid-19-ambulante.xlsx');
//                 //   },
//                 // ),
//                 // Text('open result: $_openResult\n'),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Dataset source: ',
//                       style: TextStyle(
//                         fontSize: 20,
//                         // fontStyle: FontStyle.italic,
//                         // color: Colors.blueGrey[400],
//                       ),
//                     ),
//                     InkWell(
//                         child: Text(
//                           'data.gov.rs',
//                           style: TextStyle(
//                               // fontStyle: FontStyle.italic,
//                               fontSize: 20,
//                               decoration: TextDecoration.underline,
//                               color: Colors.blue),
//                         ),
//                         onTap: () => launch(
//                             'https://data.gov.rs/sr/datasets/covid-19-registar-covid-19-ambulanti-na-teritoriji-republike-srbije/')),
//                   ],
//                 ),
//                 SizedBox(height: 20),

//                 RaisedButton(
//                   child: Text('Tap to view data table',
//                       style: TextStyle(fontSize: 20)),
//                   onPressed: () => launch(
//                     url,
//                     forceSafariVC: true,
//                     forceWebView: true,
//                     headers: <String, String>{
//                       'my_header_key': 'my_header_value'
//                     },
//                   ),
//                 ),
//                 StreamBuilder<Serbia>(
//                     stream: CoronaBloc().serbiaBehaviorSubject$.stream,
//                     builder: (context, snapshot) {
//                       Serbia serbia = CoronaBloc().serbia$;
//                       if (snapshot.hasData || serbia != null) {
//                         serbia = snapshot.data ?? serbia;
//                       }
//                       String dateText = "";
//                       if (serbia != null && serbia.updatedDate != null) {
//                         dateText =
//                             serbia.updatedDate + " " + serbia.updatedTime;
//                       }
//                       return GFListTile(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                         margin:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                         color: kPrimaryDark,
//                         title: Center(
//                           // child: Text('UKUPAN BROJ OBOLELIH\n${serbia.cases}',
//                           //     textAlign: TextAlign.center,
//                           //     style: TextStyle(color: kText, fontSize: 18)),
//                           child: RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style,
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: 'UKUPAN BROJ OBOLELIH\n',
//                                   style: TextStyle(
//                                     color: kText,
//                                     fontSize: 18,
//                                     wordSpacing: -0.7,
//                                     fontFamily:
//                                         '${GoogleFonts.sourceCodePro()}',
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '${serbia.cases}',
//                                   style: TextStyle(
//                                     color: kYellow,
//                                     fontSize: 20,
//                                     fontFamily: 'Nexa Demo',
//                                     fontWeight: FontWeight.w900,
//                                     height: 2.0,
//                                     letterSpacing: 2.3,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         subTitle: Row(
//                           children: [
//                             Text(
//                               'Source:\nworldometers.info/coronavirus',
//                               textAlign: TextAlign.start,
//                               style:
//                                   TextStyle(color: kTextDark, fontSize: 10),
//                             ),
//                             Expanded(child: SizedBox()),
//                             if (dateText != "") ...{
//                               Text(
//                                 'Last update:\n$dateText',
//                                 textAlign: TextAlign.end,
//                                 style:
//                                     TextStyle(color: kTextDark, fontSize: 10),
//                               ),
//                             },
//                           ],
//                         ),
//                       );
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           tooltip: 'Increment',
//           icon: Icon(Icons.map),
//           label: Text('Show on map'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => GMap()),
//             );
//           }),
//     );
//   });
// }

// @override
// void dispose() {
//   CoronaBloc().dispose();
//   super.dispose();
// }
// }

// StreamBuilder<Global>(
//                     stream: CoronaBloc().globalBehaviorSubject$.stream,
//                     builder: (context, snapshot) {
//                       Global global = CoronaBloc().global$;
//                       if (snapshot.hasData || global != null) {
//                         global = snapshot.data ?? global;
//                       }
//                       String dateText = "";
//                       if (global != null && global.updatedDate != null) {
//                         dateText =
//                             global.updatedDate + " " + global.updatedTime;
//                       }
//                       return GFListTile(
//                         title: Center(
//                           child: Text('UKUPAN BROJ OBOLELIH\n${global.cases}',
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.cabin(
//                                   color: kText, fontSize: 16)),
//                         ),
//                         subTitle: Row(
//                           children: [
//                             Text('Source:\nworldometers.info/coronavirus',
//                                 textAlign: TextAlign.start,
//                                 style: GoogleFonts.cabin(
//                                     color: kTextDark, fontSize: 10)),
//                             Expanded(child: SizedBox()),
//                             if (dateText != "") ...{
//                               Text('Last update:\n$dateText',
//                                   textAlign: TextAlign.end,
//                                   style: GoogleFonts.cabin(
//                                       color: kTextDark, fontSize: 10))
//                             }
//                           ],
//                         ),
//                       );
//                     })

// void runMyApp() {
//   runZoned<Future<void>>(
//     () async {
//       runApp(DevicePreview(
//         builder: (context) => MyApp(),
//       ));
//     },
//     onError: (dynamic error, StackTrace stackTrace) async {
// //      await FireBaseManager().logException(
// //        error,
// //        stackTrace: stackTrace,
// //      );
//     },
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: DevicePreview.appBuilder,
//       title: 'Covid-19 Ambulante',
