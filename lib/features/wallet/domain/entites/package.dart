import 'package:masaj/core/domain/entities/entity.dart';
import 'package:masaj/core/domain/value_objects/price.dart';

class Package extends Entity<String> {
  final Price price, plusFree;

  const Package(
      {required this.price, required super.id, required this.plusFree});
}
