import 'package:c19_app_srb/views/gmap_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../views/home_view.dart';
import '../views/news_view.dart';
import '../views/gmap_view.dart';
import 'kolorz.dart';

class AppNavigator extends StatefulWidget {
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomeView(), GMapView(), NewsView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      // appBar: 'des',

      body: _pages[_currentIndex],
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      //     boxShadow: [
      //       BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
      //     ],
      //   ),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      //     child: BottomNavigationBar(
      //       onTap: (int val) {
      //         if (val == _currentIndex) return;
      //         setState(() {
      //           _currentIndex = val;
      //         });
      //       },
      //       currentIndex: _currentIndex,
      //       unselectedLabelStyle:
      //           GoogleFonts.openSans(fontWeight: _labelFontStyle),
      //       unselectedIconTheme: IconThemeData(color: kPrimary),
      //       selectedIconTheme: IconThemeData(color: kPrimaryDark),
      //       selectedLabelStyle:
      //           GoogleFonts.openSans(fontWeight: _labelFontStyle),
      //       items: <BottomNavigationBarItem>[
      //         BottomNavigationBarItem(
      //             icon: FaIcon(FontAwesomeIcons.thermometer),
      //             title: Text('Stats', style: _labelStyle)),
      //         BottomNavigationBarItem(
      //             icon: FaIcon(FontAwesomeIcons.clinicMedical),
      //             title: Text('Map', style: _labelStyle)),
      //         BottomNavigationBarItem(
      //             icon: FaIcon(FontAwesomeIcons.globeEurope),
      //             title: Text('Global', style: _labelStyle)),
      //       ],
      //     ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: kPrimaryDark, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10).add(EdgeInsets.only(top: 5)),
            child: GNav(
              gap: 10,
              activeColor: kYellow,
              color: kTextDark,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey[800],
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  backgroundColor: kSecondaryDark,
                ),
                GButton(
                  icon: LineIcons.map,
                  text: 'Map',
                  backgroundColor: kSecondaryDark,
                ),
                GButton(
                  icon: LineIcons.newspaper_o,
                  text: 'News',
                  backgroundColor: kSecondaryDark,
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                  backgroundColor: Colors.green,
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (int val) {
                if (val == _currentIndex) return;
                setState(() {
                  _currentIndex = val;
                });
              },
            ),
          ),
        ),
      ),
    );
    //   ),
    // );
  }

  TextStyle get _labelStyle => TextStyle(color: kPrimaryDark);

  FontWeight get _labelFontStyle => FontWeight.bold;
}
