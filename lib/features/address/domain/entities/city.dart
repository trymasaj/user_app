import 'package:masaj/core/domain/value_objects/localized_name.dart';

class Area {
  final LocalizedName name;
  final int id;

  Area({required this.name, required this.id});


  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      name: LocalizedName.fromMap(map) ,
      id: map['id'] as int,
    );
  }
}
