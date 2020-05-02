// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ambulante _$AmbulanteFromJson(Map<String, dynamic> json) {
  return Ambulante(
    cOVIDAmbulantaPriZdravstvenojUstanovi:
        json['COVID_ambulanta_pri_zdravstvenoj_ustanovi'] as String,
    gradOpTina: json['Grad/opština'] as String,
    adresa: json['Adresa'] as String,
    brojZgrade: json['Broj_zgrade'] as int,
    geoLatitude: (json['Geo_Latitude'] as num)?.toDouble(),
    geoLongitude: (json['Geo_Longitude'] as num)?.toDouble(),
    kontaktTelefon: json['Kontakt_telefon'] as String,
    mobilniTelefon: json['Mobilni_telefon'] as String,
    radniDanRadnoVremeOd: json['Radni_dan_radno_vreme_od'] as int,
    radniDanRadnoVremeDo: json['Radni_dan_radno_vreme_do'] as int,
    vikendRadnoVremeOd: json['Vikend_radno_vreme_od'] as int,
    vikendRadnoVremeDo: json['Vikend_radno_vreme_do'] as int,
    prilazZaInvalide: json['Prilaz_za_invalide'] as String,
  );
}

Map<String, dynamic> _$AmbulanteToJson(Ambulante instance) => <String, dynamic>{
      'COVID_ambulanta_pri_zdravstvenoj_ustanovi':
          instance.cOVIDAmbulantaPriZdravstvenojUstanovi,
      'Grad/opština': instance.gradOpTina,
      'Adresa': instance.adresa,
      'Broj_zgrade': instance.brojZgrade,
      'Geo_Latitude': instance.geoLatitude,
      'Geo_Longitude': instance.geoLongitude,
      'Kontakt_telefon': instance.kontaktTelefon,
      'Mobilni_telefon': instance.mobilniTelefon,
      'Radni_dan_radno_vreme_od': instance.radniDanRadnoVremeOd,
      'Radni_dan_radno_vreme_do': instance.radniDanRadnoVremeDo,
      'Vikend_radno_vreme_od': instance.vikendRadnoVremeOd,
      'Vikend_radno_vreme_do': instance.vikendRadnoVremeDo,
      'Prilaz_za_invalide': instance.prilazZaInvalide,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    ambulante: (json['ambulante'] as List)
        ?.map((e) =>
            e == null ? null : Ambulante.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'ambulante': instance.ambulante,
    };
