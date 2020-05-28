import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/home_view.dart';
import '../views/gmap_view.dart';
import 'kolorz.dart';

class AppNavigator extends StatefulWidget {
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _currentIndex = 0;
  List<Widget> _pages = [HomeView(), GmapView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      // appBar: 'des',

      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          child: BottomNavigationBar(
            onTap: (int val) {
              if (val == _currentIndex) return;
              setState(() {
                _currentIndex = val;
              });
            },
            currentIndex: _currentIndex,
            unselectedLabelStyle:
                GoogleFonts.openSans(fontWeight: _labelFontStyle),
            unselectedIconTheme: IconThemeData(color: kPrimary),
            selectedIconTheme: IconThemeData(color: kPrimaryDark),
            selectedLabelStyle:
                GoogleFonts.openSans(fontWeight: _labelFontStyle),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.thermometer),
                  title: Text('Stats', style: _labelStyle)),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.clinicMedical),
                  title: Text('Map', style: _labelStyle)),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.globeEurope),
                  title: Text('Global', style: _labelStyle)),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(color: kPrimaryDark);

  FontWeight get _labelFontStyle => FontWeight.bold;
}
