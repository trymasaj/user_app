// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:masaj/core/presentation/models/selection_popup_model.dart';

/// This class defines the variables used in the [select_location_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SelectLocationModel extends Equatable {
  SelectLocationModel({
    this.dropdownItemList = const [],
    this.dropdownItemList1 = const [],
  }) {}

  List<SelectionPopupModel> dropdownItemList;

  List<SelectionPopupModel> dropdownItemList1;

  SelectLocationModel copyWith({
    List<SelectionPopupModel>? dropdownItemList,
    List<SelectionPopupModel>? dropdownItemList1,
  }) {
    return SelectLocationModel(
      dropdownItemList: dropdownItemList ?? this.dropdownItemList,
      dropdownItemList1: dropdownItemList1 ?? this.dropdownItemList1,
    );
  }

  @override
  List<Object?> get props => [dropdownItemList, dropdownItemList1];
}
