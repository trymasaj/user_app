import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';
import 'package:masaj/features/medical_form/data/repo/medical_form_repo.dart';

import '../../../../../core/domain/exceptions/redundant_request_exception.dart';

part 'medical_form_state.dart';

/// A bloc that manages the state of a MedicalForm according to the event that is dispatched to it.
class MedicalFormBloc extends BaseCubit<MedicalFormState> {
  MedicalFormBloc(this._medicalFormRepo) : super(const MedicalFormState());
  final MedicalFormRepository _medicalFormRepo;

  void saveSelectedConditions(List<MedicalCondition>? conditions) {
    if (conditions == null) return;

    emit(state.copyWith(
        selectedConditions: conditions,
        status: MedicalFormStateStatus.conditionSaved));
  }

  Future<void> getConditions() async {
    emit(state.copyWith(status: MedicalFormStateStatus.loading));
    try {
      final conditions = await _medicalFormRepo.getConditions();
      emit(state.copyWith(
          status: MedicalFormStateStatus.loaded, conditions: conditions));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MedicalFormStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getMedicalForm() async {
    emit(state.copyWith(status: MedicalFormStateStatus.loading));
    try {
      final medicalForm = await _medicalFormRepo.getMedicalForm();
      emit(state.copyWith(
          status: MedicalFormStateStatus.loaded, medicalForm: medicalForm));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MedicalFormStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addMedicalForm(MedicalForm? medicalForm) async {
    if (medicalForm == null) return;
    emit(state.copyWith(status: MedicalFormStateStatus.loading));
    try {
      final addMedicalForm = await _medicalFormRepo.addMedicalForm(medicalForm);
      emit(state.copyWith(
          status: MedicalFormStateStatus.loaded, medicalForm: addMedicalForm));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: MedicalFormStateStatus.error, errorMessage: e.toString()));
    }
  }

  void clear() {
    emit(state.copyWith(selectedConditions: []));
  }
}
