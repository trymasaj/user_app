import 'package:masaj/core/data/models/query_model.dart';
import 'package:masaj/features/providers_tab/enums/taps_enum.dart';

class ProvideQueryModel extends QueryModel {
  final TherapistTabsEnum? tabFilter;

  const ProvideQueryModel({
    required this.tabFilter,
    super.page,
    super.pageSize,
    super.searchKey,
  });
  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'TabFilter': tabFilter?.index,
      });
  }
}
