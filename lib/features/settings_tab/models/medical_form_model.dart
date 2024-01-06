// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:masaj/core/widgets/selection_popup_model.dart';

/// This class defines the variables used in the [medical_form_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MedicalFormModel extends Equatable {
  MedicalFormModel({this.dropdownItemList = const []}) {}

  List<SelectionPopupModel> dropdownItemList;

  MedicalFormModel copyWith({List<SelectionPopupModel>? dropdownItemList}) {
    return MedicalFormModel(
      dropdownItemList: dropdownItemList ?? this.dropdownItemList,
    );
  }

  @override
  List<Object?> get props => [dropdownItemList];
}
