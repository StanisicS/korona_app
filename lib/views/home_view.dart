import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_maps_int/models/serbia.dart';
import 'package:google_maps_int/repository/corona_bloc.dart';
import 'package:google_maps_int/responsive/responsive_builder.dart';
import 'package:google_maps_int/utils/kolorz.dart';
// import 'package:google_maps_int/utils/package_Info.dart';
import 'package:responsive_screen/responsive_screen.dart';
import '../utils/margin.dart';
import './nav_rail_widget.dart';

// Future<void> init() async {
//   CoronaBloc();
//   await initPackageInfo();
// }

class HomeView extends StatefulWidget {
  // final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  // void dispose() {
  //   CoronaBloc().dispose();
  //   super.dispose();
  // }
}
