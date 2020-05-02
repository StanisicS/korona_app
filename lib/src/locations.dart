import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Locations {
  Locations(
      {this.cOVIDAmbulantaPriZdravstvenojUstanovi,
      this.gradOpTina,
      this.adresa,
      this.brojZgrade,
      this.geoLatitude,
      this.geoLongitude,
      this.kontaktTelefon,
      this.mobilniTelefon,
      this.radniDanRadnoVremeOd,
      this.radniDanRadnoVremeDo,
      this.vikendRadnoVremeOd,
      this.vikendRadnoVremeDo,
      this.prilazZaInvalide});

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final String cOVIDAmbulantaPriZdravstvenojUstanovi;
  final String gradOpTina;
  final String adresa;
  final int brojZgrade;
  final double geoLatitude;
  final double geoLongitude;
  final String kontaktTelefon;
  final String mobilniTelefon;
  final int radniDanRadnoVremeOd;
  final int radniDanRadnoVremeDo;
  final int vikendRadnoVremeOd;
  final int vikendRadnoVremeDo;
  final String prilazZaInvalide;

  // : cOVIDAmbulantaPriZdravstvenojUstanovi =
  //       json['COVID_ambulanta_pri_zdravstvenoj_ustanovi'],
  //   gradOpTina = json['Grad/opština'],
  //   adresa = json['Adresa'],
  //   brojZgrade = json['Broj_zgrade'],
  //   geoLatitude = json['Geo_Latitude'],
  //   geoLongitude = json['Geo_Longitude'],
  //   kontaktTelefon = json['Kontakt_telefon'],
  //   mobilniTelefon = json['Mobilni_telefon'],
  //   radniDanRadnoVremeOd = json['Radni_dan_radno_vreme_od'],
  //   radniDanRadnoVremeDo = json['Radni_dan_radno_vreme_do'],
  //   vikendRadnoVremeOd = json['Vikend_radno_vreme_od'],
  //   vikendRadnoVremeDo = json['Vikend_radno_vreme_do'],
  //   prilazZaInvalide = json['Prilaz_za_invalide'];

  // Map<String, dynamic> toJson() => {
  //       // final Map<String, dynamic> data = new Map<String, dynamic>();
  //       'COVID_ambulanta_pri_zdravstvenoj_ustanovi':
  //           cOVIDAmbulantaPriZdravstvenojUstanovi,
  //       'Grad/opština': gradOpTina,
  //       'Adresa': adresa,
  //       'Broj_zgrade': brojZgrade,
  //       'Geo_Latitude': geoLatitude,
  //       'Geo_Longitude': geoLongitude,
  //       'Kontakt_telefon': kontaktTelefon,
  //       'Mobilni_telefon': mobilniTelefon,
  //       'Radni_dan_radno_vreme_od': radniDanRadnoVremeOd,
  //       'Radni_dan_radno_vreme_do': radniDanRadnoVremeDo,
  //       'Vikend_radno_vreme_od': vikendRadnoVremeOd,
  //       'Vikend_radno_vreme_do': vikendRadnoVremeDo,
  //       'Prilaz_za_invalide': prilazZaInvalide,
  //     };
}

@JsonSerializable()
class Ambulante {
  Ambulante({
    this.ambulante,
  });

  factory Ambulante.fromJson(Map<String, dynamic> json) =>
      _$AmbulanteFromJson(json);
  Map<String, dynamic> toJson() => _$AmbulanteToJson(this);

  final List<Ambulante> ambulante;
}

// Map locationsMap = jsonDecode(jsonString);
// var location = Locations.fromJson(locationsMap);
// String json = jsonEncode(location);

Future<Locations> getCovidAmbulante() async {
  const covidAmbulanteURL =
      'https://raw.githubusercontent.com/StanisicS/google_maps_int/master/lib/src/covid-19-ambulante.json';
  // Retrieve the locations of Google offices
  final response = await http.get(covidAmbulanteURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(covidAmbulanteURL));
  }
}
