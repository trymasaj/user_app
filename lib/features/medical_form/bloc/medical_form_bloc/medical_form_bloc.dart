import 'package:equatable/equatable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/models/selection_popup_model.dart';

part 'medical_form_state.dart';

/// A bloc that manages the state of a MedicalForm according to the event that is dispatched to it.
class MedicalFormBloc extends Cubit<MedicalFormState> {
  MedicalFormBloc(super.initialState);

  void _changeDropDown() {
    emit(state.copyWith());
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: 'Item One',
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: 'Item Two',
      ),
      SelectionPopupModel(
        id: 3,
        title: 'Item Three',
      )
    ];
  }

  void _onInitialize() async {}
}
