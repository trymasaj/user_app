import 'package:masaj/core/data/models/query_model.dart';

enum BookingQueryStatus {
  completed,
  upcoming,
}

class BookingQueryModel extends QueryModel {
  final BookingQueryStatus? status;

  const BookingQueryModel({
    required this.status,
    super.page,
    super.pageSize,
    super.searchKeyword,
  });
  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'status': status?.index,
      });
  }
}
