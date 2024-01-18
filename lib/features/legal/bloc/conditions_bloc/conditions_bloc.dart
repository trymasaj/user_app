import 'package:equatable/equatable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/legal/models/conditionslist_item_model.dart';
part 'conditions_state.dart';

/// A bloc that manages the state of a Conditions according to the event that is dispatched to it.
class ConditionsBloc extends Cubit<ConditionsState> {
  ConditionsBloc(super.state);

  void getConditions() {
    return emit(state.copyWith(conditions: [
      Condition(name: 'Allergies', id: ''),
      Condition(name: 'Edema', id: ''),
      Condition(name: 'Sciatica', id: ''),
      Condition(name: 'Epilepsy', id: ''),
      Condition(name: 'Skin disorders', id: ''),
      Condition(name: 'High/low blood pressure', id: ''),
      Condition(name: 'Extremity numbness', id: ''),
      Condition(name: 'Skin sensitivity', id: ''),
      Condition(name: 'Muscle pain/discomfort', id: ''),
      Condition(name: 'Heart conditions', id: ''),
      Condition(name: 'Cancer', id: '')
    ]));
  }
}
