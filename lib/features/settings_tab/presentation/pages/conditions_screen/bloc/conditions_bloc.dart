import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/conditions_screen/models/conditions_model.dart';
import '/core/app_export.dart';
import '../models/conditionslist_item_model.dart';
part 'conditions_event.dart';
part 'conditions_state.dart';

/// A bloc that manages the state of a Conditions according to the event that is dispatched to it.
class ConditionsBloc extends Bloc<ConditionsEvent, ConditionsState> {
  ConditionsBloc(ConditionsState initialState) : super(initialState) {
    on<ConditionsInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
    on<ChangeCheckBox1Event>(_changeCheckBox1);
    on<ChangeCheckBox2Event>(_changeCheckBox2);
    on<ChangeCheckBox3Event>(_changeCheckBox3);
    on<ChangeCheckBox4Event>(_changeCheckBox4);
    on<ChangeCheckBox5Event>(_changeCheckBox5);
    on<ChangeCheckBox6Event>(_changeCheckBox6);
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(osteoporosis: event.value));
  }

  _changeCheckBox1(
    ChangeCheckBox1Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(pregnancyCheckbox: event.value));
  }

  _changeCheckBox2(
    ChangeCheckBox2Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(thumbsup: event.value));
  }

  _changeCheckBox3(
    ChangeCheckBox3Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(chestPainCheckbox: event.value));
  }

  _changeCheckBox4(
    ChangeCheckBox4Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(varicoseVeinsCheckbox: event.value));
  }

  _changeCheckBox5(
    ChangeCheckBox5Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(neckpain: event.value));
  }

  _changeCheckBox6(
    ChangeCheckBox6Event event,
    Emitter<ConditionsState> emit,
  ) {
    emit(state.copyWith(diabetesCheckbox: event.value));
  }

  List<ConditionslistItemModel> fillConditionslistItemList() {
    return [
      ConditionslistItemModel(allergiesText: "Allergies"),
      ConditionslistItemModel(allergiesText: "Edema"),
      ConditionslistItemModel(allergiesText: "Sciatica"),
      ConditionslistItemModel(allergiesText: "Epilepsy"),
      ConditionslistItemModel(allergiesText: "Skin disorders"),
      ConditionslistItemModel(allergiesText: "High/low blood pressure"),
      ConditionslistItemModel(allergiesText: "Extremity numbness"),
      ConditionslistItemModel(allergiesText: "Skin sensitivity"),
      ConditionslistItemModel(allergiesText: "Muscle pain/discomfort"),
      ConditionslistItemModel(allergiesText: "Heart conditions"),
      ConditionslistItemModel(allergiesText: "Cancer")
    ];
  }

  _onInitialize(
    ConditionsInitialEvent event,
    Emitter<ConditionsState> emit,
  ) async {
    emit(state.copyWith(
        osteoporosis: false,
        pregnancyCheckbox: false,
        thumbsup: false,
        chestPainCheckbox: false,
        varicoseVeinsCheckbox: false,
        neckpain: false,
        diabetesCheckbox: false));
    emit(state.copyWith(
        conditionsModelObj: state.conditionsModelObj
            ?.copyWith(conditionslistItemList: fillConditionslistItemList())));
  }
}
