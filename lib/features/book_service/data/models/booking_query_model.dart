import 'package:easy_localization/easy_localization.dart';
import 'package:masaj/core/data/models/query_model.dart';

enum BookingQueryStatus {
  upcoming('upcoming', 1),
  completed('completed', 0);

  String get name => _name.tr();

  final String _name;
  final int id;

  const BookingQueryStatus(this._name, this.id);
}

class BookingQueryModel extends QueryModel {
  final BookingQueryStatus? status;

  const BookingQueryModel({
    required this.status,
    super.page,
    super.pageSize,
    super.searchKey,
  });
  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'status': status?.id,
      });
  }
}
