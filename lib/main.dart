import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
<<<<<<< HEAD
import 'package:url_launcher/url_launcher.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:async';
=======
>>>>>>> parent of 7f3520b... show bottom sheet onTap

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _mapController = Completer();
  BitmapDescriptor pinLocationIcon;
  Position position;
<<<<<<< HEAD
  GoogleMapController mapController;
  Place _selectedPlace;
=======

>>>>>>> parent of 7f3520b... show bottom sheet onTap
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('denied');
        break;
      case GeolocationStatus.disabled:
        showToast('disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Access granted');
        _getCurrentLocation();
    }
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      // _child = _mapWidget();
    });
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    // Position res = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/ambulance-pin.png');
    final covidAmbulante = await locations.getCovidAmbulante();
    await controller.setMapStyle(Utils.mapStyles);

    setState(() {
      // position = res;
      _markers.clear();
      // _markers.addAll(Marker(icon: pinLocationIcon));

      for (final ambulante in covidAmbulante.ambulante) {
        final marker = Marker(
          markerId: MarkerId(ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi),
          position: LatLng(ambulante.geoLatitude, ambulante.geoLongitude),
          icon: pinLocationIcon,
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.domain),
                          title: Text(
                            '${ambulante.adresa} ${ambulante.brojZgrade}, ${ambulante.gradOpTina}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Divider(height: 5, color: Colors.green[300]),
                        ListTile(
                          leading: Icon(Icons.local_phone),
                          title: Text(
                            '${ambulante.kontaktTelefon} ${ambulante.mobilniTelefon}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Divider(height: 5, color: Colors.green[300]),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text(
                            '${ambulante.radniDanRadnoVremeOd} - ${ambulante.radniDanRadnoVremeDo}\nVIKENDOM ${ambulante.vikendRadnoVremeOd} - ${ambulante.vikendRadnoVremeDo}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Divider(height: 5, color: Colors.green[300]),
                        ListTile(
                            leading: Icon(Icons.accessible_forward),
                            title: ambulante.prilazZaInvalide
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  )),
                      ],
                    ),
                  );
                });
          },
          // infoWindow: InfoWindow(
          //   title: ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi,
          //   snippet: ambulante.adresa,
          // ),
        );
        _markers[ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('COVID-19 Ambulante u Srbiji'),
            backgroundColor: Colors.green[700],
          ),
<<<<<<< HEAD
          body: Stack(children: <Widget>[
            GoogleMap(
              onTap: (latLng) => _controller.close(),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                // target: const LatLng(44.787197, 20.457273),
                target: LatLng(position.latitude, position.longitude),
                zoom: 12,
              ),
              markers: _markers.values.toSet(),
=======
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              // target: const LatLng(44.787197, 20.457273),
              target: LatLng(position.latitude, position.longitude),
              zoom: 12,
>>>>>>> parent of 7f3520b... show bottom sheet onTap
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: SearchMapPlaceWidget(
                  apiKey: 'AIzaSyAy6SE1Zuw6erHRIEtWYY3qE9kwTDO80-A',
                  language: 'sr',
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;

                    // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                    final GoogleMapController controller =
                        await _mapController.future;
                    await controller.animateCamera(
                        CameraUpdate.newLatLng(geolocation.coordinates));
                    await controller.animateCamera(
                        CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  }, // YOUR GOOGLE MAPS API KEY
                ))
          ]),
        ),
      );
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
