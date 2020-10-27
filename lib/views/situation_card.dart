import 'package:flutter/material.dart';
import '../utils/kolorz.dart';
import '../utils/margin.dart';

class SituationCard extends StatelessWidget {
  final String caseTitle;
  final String caseData;
  final String caseUpdate;

  const SituationCard({
    Key key,
    @required this.caseTitle,
    @required this.caseData,
    @required this.caseUpdate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context, percent: 0.23),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kPrimary,
        boxShadow: [
          BoxShadow(
              color: const Color(0xff050814),
              offset: Offset(5, 5),
              blurRadius: 15)
        ],
      ),
      child: Column(
        children: <Widget>[
          const YMargin(5),
          Text(
            '$caseTitle',
            style: TextStyle(
              fontSize: 22,
              color: kText,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const YMargin(45),
          Text(
            '$caseData',
            style: TextStyle(
              fontFamily: 'Nexa Demo',
              fontSize: 28,
              color: kYellow,
              letterSpacing: 4.3,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Row(
            children: [
              Text(
                'Source:\nworldometers.info/coronavirus',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: kTextDark, fontSize: 14, fontFamily: 'Comfortaa'),
              ),
              Expanded(child: SizedBox()),
              if (caseUpdate != "") ...{
                Text(
                  'Last update:\n$caseUpdate',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: kTextDark, fontSize: 14, fontFamily: 'Comfortaa'),
                ),
              },
            ],
          ),
        ],
      ),
    );
  }
}
