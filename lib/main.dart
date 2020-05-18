import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'gmap.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import './repository/corona_bloc.dart';
import './util/package_Info.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

// import 'package:geolocator/geolocator.dart';
import './models/global.dart';
import './util/kolorz.dart';
import 'package:getflutter/getflutter.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
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
      runApp(MyApp());
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
      title: 'Covid-19 Ambulante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimary,
        scaffoldBackgroundColor: kBackground,
        canvasColor: Colors.transparent,
      ),
      home: MyHomePage(title: 'Covid-19 Ambulante'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        // color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Registar COVID-19 ambulanti na teritoriji Republike Srbije',
                  style: TextStyle(fontSize: 38, color: Color(0xFF8D8E98)),
                ),
                SizedBox(height: 20),
                //               FlatButton(
                //   child: Text('Tap to open file'),
                //   onPressed: () {
                //     OpenFile.open('assets/covid-19-ambulante.xlsx');
                //   },
                // ),
                // Text('open result: $_openResult\n'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Dataset source: ',
                      style: TextStyle(
                        fontSize: 20,
                        // fontStyle: FontStyle.italic,
                        // color: Colors.blueGrey[400],
                      ),
                    ),
                    InkWell(
                        child: Text(
                          'data.gov.rs',
                          style: TextStyle(
                              // fontStyle: FontStyle.italic,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                        onTap: () => launch(
                            'https://data.gov.rs/sr/datasets/covid-19-registar-covid-19-ambulanti-na-teritoriji-republike-srbije/')),
                  ],
                ),
                SizedBox(height: 20),

                RaisedButton(
                  child: Text('Tap to view data table',
                      style: TextStyle(fontSize: 20)),
                  onPressed: () => launch(
                    url,
                    forceSafariVC: true,
                    forceWebView: true,
                    headers: <String, String>{
                      'my_header_key': 'my_header_value'
                    },
                  ),
                ),
                StreamBuilder<Global>(
                    stream: CoronaBloc().globalBehaviorSubject$.stream,
                    builder: (context, snapshot) {
                      Global global = CoronaBloc().global$;
                      if (snapshot.hasData || global != null) {
                        global = snapshot.data ?? global;
                      }
                      String dateText = "";
                      if (global != null && global.updatedDate != null) {
                        dateText =
                            global.updatedDate + " " + global.updatedTime;
                      }
                      return GFListTile(
                          title: Center(
                            child: Text('UKUPAN BROJ OBOLELIH\n${global.cases}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cabin(
                                    color: kText, fontSize: 16)),
                          ),
                          subTitle: Row(
                            children: [
                              Text('Source:\nworldometers.info/coronavirus',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.cabin(
                                      color: kTextDark, fontSize: 10)),
                              FittedBox(fit: BoxFit.fitWidth),
                              if (dateText != "") ...{
                                Text('Last update:\n$dateText',
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.cabin(
                                        color: kTextDark, fontSize: 10))
                              }
                            ],
                          ),
                          icon: Icon(Icons.favorite));
                    })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          tooltip: 'Increment',
          icon: Icon(Icons.map),
          label: Text('Show on map'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GMap()),
            );
          }),
    );
  }

  @override
  void dispose() {
    CoronaBloc().dispose();
    super.dispose();
  }
}

// StreamBuilder<global>(
//                   stream: CoronaBloc().serbiaBehaviorSubject$.stream,
//                   builder: (context, snapshot) {
//                     global global = CoronaBloc().global$;
//                     if (snapshot.hasData || global != null) {
//                       global = snapshot.data ?? global;
//                     }
//                     String dateText = "";
//                     if (global != null && global.updatedDate != null) {
//                       dateText = global.updatedDate + " " + global.updatedTime;
//                     }
//                     return GFListTile(
//                         title: Center(
//                           child: Text('UKUPAN BROJ OBOLELIH\n${global.cases}',
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.cabin(
//                                   color: kText, fontSize: 16)),
//                         ),
//                         subTitle: Row(
//                           children: [
//                             Text('Source:\nworldometers.info/coronavirus',
//                                 textAlign: TextAlign.left,
//                                 style: GoogleFonts.cabin(
//                                     color: kTextDark, fontSize: 10)),
//                             Expanded(child: null),
//                             if (dateText != "") ...{
//                               Text('Last update:\n$dateText',
//                                   textAlign: TextAlign.right,
//                                   style: GoogleFonts.cabin(
//                                       color: kTextDark, fontSize: 10))
//                             }
//                           ],
//                         ),
//                         icon: Icon(Icons.favorite));
//                   })
