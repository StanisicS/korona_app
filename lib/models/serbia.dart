class Serbia {
  int cases;
  int deaths;
  int recovered;
  int todayCases;
  int todayDeaths;

  Serbia.fromJsonMap(Map<String, dynamic> map)
      : cases = map["cases"] ?? 0,
        deaths = map["deaths"] ?? 0,
        recovered = map["recovered"] ?? 0,
        todayCases = map["todayCases"] ?? 0,
        todayDeaths = map["todayDeaths"] ?? 0;

  // Serbia(
  //     {this.cases,
  //     this.deaths,
  //     this.recovered,
  //     this.todayCases,
  //     this.todayDeaths});

  Serbia.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    todayCases = json['todayCases'];
    todayDeaths = json['todayDeaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['UKUPAN BROJ OBOLELIH'] = cases;
    data['UKUPAN BROJ PREMINULIH'] = deaths;
    data['UKUPAN BROJ IZLEČENIH'] = recovered;
    data['BROJ OBOLELIH U POSLEDNJA 24 ČASA'] = todayCases;
    data['BROJ PREMINULIH U POSLEDNJA 24 ČASA'] = todayDeaths;

    return data;
  }
}
