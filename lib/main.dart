import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// class _MyAppState extends State<MyApp> {
//   GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final covidAmbulante = await locations.getCovidAmbulante();
    setState(() {
      _markers.clear();

      for (final ambulante in covidAmbulante.ambulante) {
        final marker = Marker(
          markerId: MarkerId(ambulante.gradOpTina),
          position: LatLng(ambulante.geoLatitude, ambulante.geoLongitude),
          infoWindow: InfoWindow(
            title: ambulante.cOVIDAmbulantaPriZdravstvenojUstanovi,
            snippet: '${ambulante.adresa} + ${ambulante.brojZgrade}',
          ),
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
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(44.787197, 20.457273),
              zoom: 2,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
