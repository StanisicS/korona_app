import 'package:intl/intl.dart';

class Serbia {
  int cases;
  int deaths;
  int recovered;
  int todayCases;
  int todayDeaths;
  String updatedDate;
  String updatedTime;
  static DateFormat formatter = DateFormat("MMM d y");
  static DateFormat timeFormatter = DateFormat().add_jm();

  Serbia.fromJsonMap(Map<String, dynamic> map)
      : cases = map["cases"] ?? 0,
        deaths = map["deaths"] ?? 0,
        recovered = map["recovered"] ?? 0,
        todayCases = map["todayCases"] ?? 0,
        todayDeaths = map["todayDeaths"] ?? 0,
        updatedDate = toDate(map["updated"], formatter),
        updatedTime = toDate(map["updated"], timeFormatter);

  // Serbia(
  //     {this.cases,
  //     this.deaths,
  //     this.recovered,
  //     this.todayCases,
  //     this.todayDeaths});

  // Serbia.fromJson(Map<String, dynamic> json) {
  //   cases = json['cases'];
  //   deaths = json['deaths'];
  //   recovered = json['recovered'];
  //   todayCases = json['todayCases'];
  //   todayDeaths = json['todayDeaths'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cases'] = cases;
    data['deaths'] = deaths;
    data['recovered'] = recovered;
    data['todayCases'] = todayCases;
    data['todayDeaths'] = todayDeaths;

    return data;
  }

  static String toDate(int date, DateFormat formatter) {
    try {
      if (date != null) {
        return formatter.format(DateTime.fromMillisecondsSinceEpoch(date));
      }
    } catch (ex) {
      return "";
    }
    return "";
  }
}

// UKUPAN BROJ OBOLELIH
// UKUPAN BROJ PREMINULIH
// UKUPAN BROJ IZLEČENIH
// BROJ OBOLELIH U POSLEDNJA 24 ČASA
// BROJ PREMINULIH U POSLEDNJA 24 ČASA
