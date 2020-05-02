// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    cOVIDAmbulantaPriZdravstvenojUstanovi:
        json['cOVIDAmbulantaPriZdravstvenojUstanovi'] as String,
    gradOpTina: json['gradOpTina'] as String,
    adresa: json['adresa'] as String,
    brojZgrade: json['brojZgrade'] as int,
    geoLatitude: (json['geoLatitude'] as num)?.toDouble(),
    geoLongitude: (json['geoLongitude'] as num)?.toDouble(),
    kontaktTelefon: json['kontaktTelefon'] as String,
    mobilniTelefon: json['mobilniTelefon'] as String,
    radniDanRadnoVremeOd: json['radniDanRadnoVremeOd'] as int,
    radniDanRadnoVremeDo: json['radniDanRadnoVremeDo'] as int,
    vikendRadnoVremeOd: json['vikendRadnoVremeOd'] as int,
    vikendRadnoVremeDo: json['vikendRadnoVremeDo'] as int,
    prilazZaInvalide: json['prilazZaInvalide'] as String,
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'cOVIDAmbulantaPriZdravstvenojUstanovi':
          instance.cOVIDAmbulantaPriZdravstvenojUstanovi,
      'gradOpTina': instance.gradOpTina,
      'adresa': instance.adresa,
      'brojZgrade': instance.brojZgrade,
      'geoLatitude': instance.geoLatitude,
      'geoLongitude': instance.geoLongitude,
      'kontaktTelefon': instance.kontaktTelefon,
      'mobilniTelefon': instance.mobilniTelefon,
      'radniDanRadnoVremeOd': instance.radniDanRadnoVremeOd,
      'radniDanRadnoVremeDo': instance.radniDanRadnoVremeDo,
      'vikendRadnoVremeOd': instance.vikendRadnoVremeOd,
      'vikendRadnoVremeDo': instance.vikendRadnoVremeDo,
      'prilazZaInvalide': instance.prilazZaInvalide,
    };

Ambulante _$AmbulanteFromJson(Map<String, dynamic> json) {
  return Ambulante(
    ambulante: (json['ambulante'] as List)
        ?.map((e) =>
            e == null ? null : Locations.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AmbulanteToJson(Ambulante instance) => <String, dynamic>{
      'ambulante': instance.ambulante,
    };
