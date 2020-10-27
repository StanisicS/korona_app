import 'package:catcher/catcher.dart';
import 'package:catcher/core/catcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

main() {
  //debug configuration
  CatcherOptions debugOptions =
      CatcherOptions(SilentReportMode(), [ConsoleHandler()]);

  //release configuration
  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
    EmailManualHandler(["stevan.stanisic@outlook.com"])
  ]);

  //MyApp is root widget
  Catcher(GMapView(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class GMapView extends StatefulWidget {
  GMapView({
    Key key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  _GMapViewState createState() => _GMapViewState();
}

class _GMapViewState extends State<GMapView> {
  BitmapDescriptor pinLocationIcon;
  Position position;
  GoogleMapController mapController;
  PersistentBottomSheetController _controller;

  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getLocation() async {
    var userLocation = await Location().getLocation();
    setState(() {
      longitude = userLocation.longitude;
      latitude = userLocation.latitude;
    });
  }

  double latitude;
  double longitude;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/ambulance-pin.png');
    final covidAmbulante = await locations.getCovidAmbulante();
    await controller.setMapStyle(Utils.mapStyles);

    setState(() {
      _markers.clear();

      for (final ambulante in covidAmbulante.ambulante) {
        final marker = Marker(
            markerId: MarkerId(ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi),
            position: LatLng(ambulante.geoLatitude, ambulante.geoLongitude),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
                title: ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi,
                snippet: 'Tap here to zoom in',
                onTap: () {
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              ambulante.geoLatitude, ambulante.geoLongitude),
                          zoom: 18)));
                }),
            onTap: () {
              _controller = _scaffoldKey.currentState.showBottomSheet<void>(
                (BuildContext context) => Container(
                  color: Colors.transparent,
                  child: Container(
                    width: 260,
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.only(
                      left: 13,
                      right: 17,
                      bottom: 17,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Container(
                                width: 150,
                                height: 5,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.domain),
                          title: Text(
                            '${ambulante.adresa} ${ambulante.brojZgrade}, ${ambulante.gradOpTina}',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.local_phone),
                          title: ambulante.kontaktTelefon == null
                              ? SelectableText('${ambulante.mobilniTelefon}',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold))
                              : SelectableText(
                                  '${ambulante.kontaktTelefon}\n${ambulante.mobilniTelefon}',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () => launch(
                              'tel:${ambulante.kontaktTelefon ?? ambulante.mobilniTelefon}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text(
                            'RADNIM DANIMA: \n${ambulante.radniDanRadnoVremeOd} - ${ambulante.radniDanRadnoVremeDo}\nVIKENDOM: ${ambulante.vikendRadnoVremeOd} - ${ambulante.vikendRadnoVremeDo}',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.accessible_forward),
                          title: Text('DOSTUPAN PRILAZ',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                          trailing: ambulante.prilazZaInvalide
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.block,
                                  color: Colors.red,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
        _markers[ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Covid-19 Ambulante'),
      ),
      body: GoogleMap(
        onTap: (latLng) => _controller.close(),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 12,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8ec3b9"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1a3646"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#64779e"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#334e87"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6f9ba5"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3C7680"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#304a7d"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c6675"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#255763"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#b0d5ce"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3a4762"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#0e1626"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#4e6d70"
      }
    ]
  }
]''';
}
