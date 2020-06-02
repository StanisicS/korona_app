import 'dart:async';

import 'package:flutter/material.dart';
import '../models/serbia.dart';
import '../repository/corona_bloc.dart';
import '../responsive/responsive_builder.dart';
import '../utils/package_Info.dart';
import 'package:responsive_screen/responsive_screen.dart';
import './situation_card.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runHomeView();
}

Future<void> init() async {
  CoronaBloc();
  await initPackageInfo();
}

void runHomeView() {
  runZoned<Future<void>>(
    () async {
      runApp(
        HomeView(),
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
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Tracker Srbija'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),

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
              return Column(children: <Widget>[
                SituationCard(
                    caseTitle: 'UKUPAN BROJ OBOLELIH',
                    caseData: '${serbia.cases}',
                    caseUpdate: '$dateText'),
                SituationCard(
                    caseTitle: 'UKUPAN BROJ PREMINULIH',
                    caseData: '${serbia.deaths}',
                    caseUpdate: '$dateText'),
                SituationCard(
                    caseTitle: 'UKUPAN BROJ IZLEČENIH',
                    caseData: '${serbia.recovered}',
                    caseUpdate: '$dateText'),
                SituationCard(
                    caseTitle: 'BROJ OBOLELIH U POSLEDNJA 24 ČASA',
                    caseData: '${serbia.todayCases}',
                    caseUpdate: '$dateText'),
                SituationCard(
                    caseTitle: 'BROJ PREMINULIH U POSLEDNJA 24 ČASA',
                    caseData: '${serbia.todayDeaths}',
                    caseUpdate: '$dateText'),
              ]);
            },
          ),
        ),
      );
    });
  }

  void dispose() {
    CoronaBloc().dispose();
    super.dispose();
  }
}
