import 'package:flutter/foundation.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';

enum MedicalFormStateStatus {
  initial,
  loading,
  loaded,
  getMedicalForm,
  loadedCondition,
  error,
  deleted,
  added,
  conditionSaved
}

extension MedicalFormStateX on MedicalFormState {
  bool get isInitial => status == MedicalFormStateStatus.initial;
  bool get isLoading => status == MedicalFormStateStatus.loading;
  bool get isGetMedicalForm => status == MedicalFormStateStatus.getMedicalForm;
  bool get isLoaded => status == MedicalFormStateStatus.loaded;
  bool get isError => status == MedicalFormStateStatus.error;
  bool get isDeleted => status == MedicalFormStateStatus.deleted;
  bool get isAdded => status == MedicalFormStateStatus.added;
  bool get isConditionSaved => status == MedicalFormStateStatus.conditionSaved;
}

class MedicalFormState {
  final MedicalFormStateStatus status;
  final List<MedicalCondition>? conditions;
  final List<MedicalCondition>? selectedConditions;
  final MedicalForm? medicalForm;
  final String? errorMessage;

  const MedicalFormState({
    this.conditions,
    this.selectedConditions,
    this.medicalForm,
    this.status = MedicalFormStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as MedicalFormState).status == status &&
        listEquals(other.conditions, conditions) &&
        listEquals(other.selectedConditions, selectedConditions) &&
        other.medicalForm == medicalForm &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      Object.hashAll(conditions ?? []) ^
      Object.hashAll(selectedConditions ?? []) ^
      medicalForm.hashCode;

  MedicalFormState copyWith({
    MedicalFormStateStatus? status,
    String? errorMessage,
    MedicalForm? medicalForm,
    List<MedicalCondition>? conditions,
    List<MedicalCondition>? selectedConditions,
  }) {
    return MedicalFormState(
      status: status ?? this.status,
      conditions: conditions ?? this.conditions,
      errorMessage: errorMessage ?? this.errorMessage,
      medicalForm: medicalForm ?? this.medicalForm,
      selectedConditions: selectedConditions ?? this.selectedConditions,
    );
  }
}
