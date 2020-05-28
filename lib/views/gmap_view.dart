import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_int/repository/corona_bloc.dart';
import 'package:google_maps_int/responsive/responsive_builder.dart';
import 'package:google_maps_int/utils/kolorz.dart';
import 'package:location/location.dart';
// import 'package:google_maps_int/utils/package_Info.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../gmap.dart';
import '../main.dart';
import '../utils/margin.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runGmapView();
}

void runGmapView() {
  runZoned<Future<void>>(
    () async {
      runApp(
        GmapView(),
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

class GmapView extends StatefulWidget {
  GmapView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GmapViewState createState() => _GmapViewState();
}

class _GmapViewState extends State<GmapView> {
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
            child: Center(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                  ])),
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
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    CoronaBloc().dispose();
    super.dispose();
  }
}
