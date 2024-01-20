import 'package:masaj/core/domain/value_objects/localized_name.dart';

class City {
  final LocalizedName name;
  final int id;

  City({required this.name, required this.id});


  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: LocalizedName.fromMap(map) ,
      id: map['id'] as int,
    );
  }
}
