import 'package:google_fonts/google_fonts.dart';

import 'gmap.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Ambulante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1D1E33),
        primaryTextTheme: TextTheme(
            body1: GoogleFonts.cabin(
                textStyle: TextStyle(color: Color(0xFF8D8E98)))),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
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
                  headers: <String, String>{'my_header_key': 'my_header_value'},
                ),
              ),
            ],
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
}
