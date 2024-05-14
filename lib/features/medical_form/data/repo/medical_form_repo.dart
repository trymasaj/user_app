import 'package:masaj/features/medical_form/data/datasource/medical_form_datasource.dart';
import 'package:masaj/features/medical_form/data/model/condition_model.dart';
import 'package:masaj/features/medical_form/data/model/medical_form_model.dart';

abstract class MedicalFormRepository {
  Future<MedicalForm> getMedicalForm();
  Future<MedicalForm> addMedicalForm(MedicalForm medicalForm);
  Future<List<MedicalCondition>> getConditions();
}

class MedicalFormRepositoryImp extends MedicalFormRepository {
  final MedicalFormDataSource _medicalFormDataSource;

  MedicalFormRepositoryImp(this._medicalFormDataSource);

  @override
  Future<MedicalForm> addMedicalForm(MedicalForm medicalForm) =>
      _medicalFormDataSource.addMedicalForm(medicalForm);

  @override
  Future<List<MedicalCondition>> getConditions() =>
      _medicalFormDataSource.getConditions();

  @override
  Future<MedicalForm> getMedicalForm() =>
      _medicalFormDataSource.getMedicalForm();
}
